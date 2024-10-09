const admin = require("firebase-admin");
const { onCall, HttpsError } = require("firebase-functions/v2/https");
const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const { logger, region } = require("firebase-functions");
const { user } = require("firebase-functions/v1/auth");
admin.initializeApp({
    credential: admin.credential.applicationDefault(),
});

exports.sendShiftNotification = onCall(async (request, response) => {
    fcmToken = request.data.token;
    const message = {
        notification: {
            "title": "Test notification",
            "body": "This is a ShiftVerse test notification"
        },
        token: fcmToken,
    };

    admin.messaging().send(message).then((snapshot) => {
        response.send(snapshot);
    }).catch((error) => {
        console.log(error);
        throw new HttpsError("internal", 'Not able to send message');
    });
});

// function that listens to any change made 
//in sales collection and sends notification to all users

exports.alertUsersofNewSale = onDocumentCreated({ document: "Sales/{saleId}", region: "europe-west2" }, (document) => {
    // get the amount of pamphlets sold and pamphlets remaining
    var sale = document.data;
    var saleData = sale.data()

    //get the FCM token of all users from the Users collection
    admin.firestore().collection("/Users").get().then((userDocuments) => {
        logger.debug("Function has fetched records");

        // for every user document get the FCM token and send them a notification
        var allUserDocuments = userDocuments.docs;
        for (var i = 0; i < allUserDocuments.length; i++) {
            var singleUserDocument = allUserDocuments[i];
            var userData = singleUserDocument.data();
            if (userData.fcmToken == null) {
                logger.error("User does not have an FCM token");
                continue;
            } else {
                var fetchedFcmToken = userData.fcmToken;
                logger.debug("Got the fcm token from this user");
                const message = {
                    notification: {
                        "title": "Sale update",
                        "body": `Today we were able to sell ${saleData.saleAmount} worth of pamphlets and ${saleData.pamphletsLeft} remained`,
                    },
                    token: fetchedFcmToken,
                };
                admin.messaging().send(message).then((response) => {
                    return response;
                }).catch((error) => {
                    logger.error(error);
                    throw new HttpsError("internal", 'Not able to send message');
                })
            }
        }
        // userDocuments.docs.forEach((userDocument) => {
        //     var userData = userDocument.data();
        //     var fetchedFcmToken = userData.fcmToken;
        //     logger.debug("Got the fcm token from this user");
        //     const message = {
        //         notification: {
        //             "title": "Sale update",
        //             "body": `Today we were able to sell ${saleData.saleAmount} worth of pamphlets and ${saleData.pamphletsLeft} remained`,
        //         },
        //         token: fetchedFcmToken,
        //     };
        //     admin.messaging().send(message).then((response) => {
        //         return response;
        //     }).catch((error) => {
        //         logger.error(error);
        //         throw new HttpsError("internal", 'Not able to send message');
        //     })
        // })
    }).catch((error) => {
        logger.error(error)
        throw new HttpsError("internal", "not able to retreive user documents");
    })
})

const admin = require("firebase-admin");
const { onCall, HttpsError } = require("firebase-functions/v2/https");
const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const { logger } = require("firebase-functions");
const { onSchedule } = require("firebase-functions/v2/scheduler");
const { google } = require("googleapis");
const { GoogleAuth } = require("google-auth-library");
const moment = require("moment");
admin.initializeApp({
    credential: admin.credential.applicationDefault(),
});

exports.sendShiftNotification = onSchedule({
    schedule: "0 20 * * 3,6",
    timeZone: "Africa/Nairobi",
    region: "europe-west2"
}, async () => {
    // create an Google Auth client to authen
    const auth = new GoogleAuth({
        scopes: "https://www.googleapis.com/auth/spreadsheets.readonly"
    })
    // define the range where data will be fetched
    let ranges = ["Shifts!A2:G54"];

    //retrieve data from the google sheet
    const service = google.sheets({ version: "v4", auth: auth });
    try {
        const result = await service.spreadsheets.values.batchGet({
            spreadsheetId: "11Q4GWp95LfjL8Fu3DTl3fd2fmMJhCNx1CnDrF_pu7js",
            ranges: ranges
        });

        var data = result.data.valueRanges.forEach((valueRange) => {
            //get array that contains the shift data
            let dataValues = valueRange.values;
            // loop through the array checking for data for the coming Sunday
            for (let index = 0; index < dataValues.length; index++) {
                // get today's date
                let today = moment().startOf("day");

                // check if the date of the shift is after today's date
                let shiftDate = moment(dataValues[index][0], "MM/DD/YYYY").startOf("day");

                if (today.isSameOrAfter(shiftDate)) {
                    continue;
                } else {
                    // print the shift data
                    logger.debug(dataValues[index][0], dataValues[index][1], dataValues[index][2], dataValues[index][3], dataValues[index][4], dataValues[index][5], dataValues[index][6]);

                    // send notification to the first seller
                    admin.firestore().collection("/Users").where("fullNames", "==", `${dataValues[index][2]} ${dataValues[index][3]}`).get().then((userDocuments) => {
                        if (userDocuments.empty) {
                            logger.error("No records found");
                        } else {
                            userDocuments.docs.forEach((userDocument) => {
                                logger.debug("Fetched records");
                                logger.debug(userDocument.data());
                                var fetchedFcmToken = userDocument.data().fcmToken;
                                logger.debug("Got the fcm token from this user");
                                const message = {
                                    notification: {
                                        "title": "Shift reminder",
                                        "body": "You have a shift on Sunday",
                                    },
                                    token: fetchedFcmToken,
                                };
                                admin.messaging().send(message).then((response) => {
                                    return response;
                                }).catch((error) => {
                                    logger.error(error);
                                    throw new HttpsError("internal", 'Not able to send message');
                                })
                            })
                        }
                    }
                    ).catch((error) => {
                        logger.error("error fetching data", error);
                    })

                    // send to the shift notification to the second seller
                    admin.firestore().collection("/Users").where("fullNames", "==", `${dataValues[index][4]} ${dataValues[index][5]}`).get().then((userDocuments) => {
                        if (userDocuments.empty) {
                            logger.error("No records found");
                        } else {
                            userDocuments.docs.forEach((userDocument) => {
                                logger.debug("Fetched records");
                                logger.debug(userDocument.data());
                                var fetchedFcmToken = userDocument.data().fcmToken;
                                logger.debug("Got the fcm token from second seller");
                                const message = {
                                    notification: {
                                        "title": "Shift reminder",
                                        "body": "You have a shift on Sunday",
                                    },
                                    token: fetchedFcmToken,
                                };
                                admin.messaging().send(message).then((response) => {
                                    return response;
                                }).catch((error) => {
                                    logger.error(error);
                                    throw new HttpsError("internal", 'Not able to send message');
                                })
                            })
                        }
                    }
                    ).catch((error) => {
                        logger.error("error fetching data", error);
                    })

                    break;
                }

            }
        })
        //logger.debug(data);
    } catch (error) {
        logger.error(error);
    }

})

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
    }).catch((error) => {
        logger.error(error)
        throw new HttpsError("internal", "not able to retreive user documents");
    })
})

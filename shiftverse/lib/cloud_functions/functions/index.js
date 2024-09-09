const admin = require("firebase-admin");
const { onCall, HttpsError } = require("firebase-functions/v2/https");
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



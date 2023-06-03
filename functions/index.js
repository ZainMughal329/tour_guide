
const functions = require("firebase-functions");

// The Firebase Admin SDK to access Firestore.
const admin = require("firebase-admin");
admin.initializeApp();

exports.helloWorld = functions.https.onCall((data, context) => {
//  return `hello ${data.name}`;
admin.firestore().collection('user').doc(data.uid).update({
    'status' : "approve"
})
});


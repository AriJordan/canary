/* eslint-disable object-curly-spacing */
/* eslint-disable max-len */
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

const db = admin.firestore();

export const sendCanaryAlert = functions.https.onRequest(async (request, response) => {
  try {
    // TODOaj: Adapt this to the pitch canaryId
    const pitchCanary = "12-34-56-78-90-12";
    let canaryId: string = request.body.canaryId;
    if (canaryId == pitchCanary) {
      canaryId = "00-00-00-00-00-00";
    }
    const phonenumbersRef = db.collection("canaries").doc(canaryId).collection("phonenumbers");

    const snapshot = await phonenumbersRef.get();

    if (snapshot.empty) {
      console.log("No matching documents.");
      response.status(404).send("No phone numbers found!");
      return;
    }

    // Iterate through the documents and send message to each phone number
    snapshot.forEach((doc) => {
      const phoneNumber = doc.data().phonenumber;
      if (phoneNumber) {
        // Write to Firestore to trigger SMS
        db.collection("messages").add({ to: phoneNumber, body: `Canary ${canaryId} detected a smoke alarm!` });
      }
    });

    response.send(`Messages sent for Canary ID: ${canaryId}.`);
  } catch (error) {
    console.error("There was an error", error);
    response.status(500).send(error);
  }
});



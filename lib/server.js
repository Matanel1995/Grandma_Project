const { query, json } = require('express');
const express = require('express')
const app = express()
const port = 8080

const admin = require('firebase-admin');

const serviceAccount = require('C:\\Users\\Matanel\\Desktop\\fireBase.json');


admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: 'https://sign-136a7.firebaseio.com'
});

const db = admin.firestore();

app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})


app.get('/getUser', async(req, res) =>{
    // Get a reference to the document
    const docRef = db.collection('User').doc(req.query.id);

    // Get the document
    docRef.get()
    .then((doc) => {
        if (doc.exists) {
        let responseArr = [];
        responseArr.push(doc.data());
        console.log(doc.data());
        console.log(responseArr);
        res.send(responseArr);
        } else {
        console.log('No such document!');
        }
    })
    .catch((error) => {
        console.log('Error getting document:', error);
    });
})



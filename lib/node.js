const express = require('express');
const axios = require('axios');
const firebase = require('firebase');
const app = express();
const port = 3000;

var firebaseConfig = {
    apiKey: "AIzaSyAwMq1lV6-9WfCRwMUIe5Y641UnjExw1zY",
    authDomain: "stock-in-a6ee1.firebaseapp.com",
    databaseURL: "https://stock-in-a6ee1-default-rtdb.firebaseio.com",
    projectId: "stock-in-a6ee1",
    storageBucket: "stock-in-a6ee1.appspot.com",
    messagingSenderId: "514700413031",
    appId: "1:514700413031:web:039a8c57896ec4f7166cc2",
    measurementId: "G-MHLXZFB13G"
};

firebase.initializeApp(firebaseConfig);

const database = firebase.database();




//////////////
//          //
//  LISTEN  //
//          //
//////////////

app.listen(port, () => {
    console.log("App listening on port " + port);
})




////////////
//        //
//   GET  //
//        //
////////////

app.get('/stock/:code/:range/:interval', (req, res) => {
    const { code } = req.params;
    const { range } = req.params;
    const { interval } = req.params;
    console.log("Received key: " + code);
    console.log("Received range: " + range);
    console.log("Received interval: " + interval);

    axios
        .get('https://query1.finance.yahoo.com/v8/finance/chart/' + code + '?region=IN&lang=en-US&comparisons=&includePrePost=false&interval=' + interval + '&useYfid=true&range=' + range + '&corsDomain=finance.yahoo.com&.tsrc=finance')
        .then(answer => {
            console.log(`statusCode: ${answer.status}\n`);
            res.send(answer.data.chart.result[0]);
        })
        .catch(error => {
            console.error("Request failed with status code 422");
            console.error("Try changing range")
        });
})

app.get('/indices', (req, res) => {
    axios
        .get('https://www.nseindia.com/api/allIndices')
        .then(answer => {
            res.send(answer.data);
        })
        .catch(error => {
            console.error("Resource not found!\n");
        });
})




////////////
//        //
//   PUT  //
//        //
////////////

app.put('/firebase/:email/:watchlist', (req, res) => {
    const { email } = req.params;
    const { watchlist } = req.params;

    let obj = {};
    obj[watchlist] = "Stock watchlisted";

    database.ref(email + "/watchlist").update(obj)
        .then(() => {
            console.log("Stock " + watchlist + " watchlisted");
            res.status(202).send("Data accepted!");
        })
        .catch((error) => {
            console.log("Error: " + error);
            res.status(500).send("Error in updating!");
        });


});

app.put('/firebase/:email/:code/:byPrice/:qty', (req, res) => {
    const { email } = req.params;
    const { code } = req.params;
    let { byPrice } = req.params;
    let { qty } = req.params;
    let data;
    let oldByPrice = 0.0, oldQty = 0.0;

    database.ref(email + "/" + code).get()
        .then((snapshot) => {
            if (snapshot.exists)
                data = snapshot.val();
            if (data) {
                oldByPrice = data.byPrice;
                oldQty = data.qty;
            }
            if (oldQty != 0) {
                byPrice = ((oldByPrice * oldQty) + (parseFloat(byPrice) * parseFloat(qty))) / (oldQty + parseFloat(qty));
                qty = oldQty + parseFloat(qty);
            }
            // console.log("Old byPrice: " + oldByPrice);
            // console.log("Old qty: " + oldQty);
            // console.log("New byPrice: " + byPrice);
            // console.log("New qty: " + qty);

            var obj = {
                "byPrice": byPrice,
                "qty": qty
            };

            database.ref(email + "/" + code).update(obj)
                .then(() => {
                    console.log("Data updated");
                    res.status(202).send("Data accepted!");
                })
                .catch((error) => {
                    console.log("Error: " + error);
                    res.status(500).send("Error in updating!");
                });
        })
        .catch((error) => {
            console.log("Error: " + error);
            res.status(500).send("Error in getting data");
        })
});




////////////
//        //
//  POST  //
//        //
////////////

app.post('/firebase/:email', (req, res) => {
    const { email } = req.params;

    database.ref(email).set({
        "watchlist": ""
    })
        .then(() => {
            console.log("New user added");
            res.status(201).send("Account created!");
        })
        .catch((error) => {
            console.log("An error occured: " + error);
            res.status(500).send("Error in creating account!");
        });
});





//////////////
//          //
//  DELETE  //
//          //
//////////////

app.delete('/firebase/:email', (req, res) => {
    const { email } = req.params;

    database.ref(email).remove()
        .then(() => {
            console.log("Account " + email + " deleted!");
            res.status(200).send("Account deleted!");
        })
        .catch((error) => {
            console.log("Error in deleting: " + error);
            res.status(500).send("Error in deleting account!");
        })
});

app.delete('/firebase/:email/:watchlist', (req, res) => {
    const { email } = req.params;
    const { watchlist } = req.params;

    database.ref(email + "/watchlist/" + watchlist).remove()
        .then(() => {
            console.log("Stock " + watchlist + " removed from watchlist!");
            res.status(200).send("Watchlist removed");
        })
        .catch((error) => {
            console.log("Error in deleting: " + error);
            res.status(500).send("Error in deleting account!");
        })
});
const express = require('express');
const axios = require('axios');
const firebase = require('firebase');
const cors = require("cors");
const async = require('async');
const request = require('request');
const app = express();
const jwt = require('jsonwebtoken');
const port = process.env.PORT || 3000;

app.use(cors());

const header = {
    "Access-Control-Allow-Origin": "*", // Required for CORS support to work
    "Access-Control-Allow-Credentials": true, // Required for cookies, authorization headers with HTTPS
    "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
    "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE"
}

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

app.get('/firebase/stocks/:email', (req, res) => {
    const { email } = req.params;
    let data;

    database.ref(email).get()
        .then((snapshot) => {
            data = snapshot.val();
            // let obj = {};
            delete data["Hello"];

            console.log("Stocks fetched");
            res.status(200).header(header).send(data);
        })
        .catch((error) => {
            console.log("An error occured: " + error);
            res.status(500).header(header).send("Error in fetching stocks!");
        });
});

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
            res.status(200).header(header).send(answer.data.chart.result[0]);
        })
        .catch(error => {
            // console.error("Request failed with status code 422");
            // console.error("Try changing range")
            console.log(`statusCode: 404\n`);
            res.status(404).send("Data not found!");
        });
})

app.get('/indices', (req, res) => {
    axios
        .get('https://www.nseindia.com/api/allIndices')
        .then(answer => {
            res.status(200).header(header).send(answer.data);
        })
        .catch(error => {
            console.error("Resource not found!\n");
            res.status(200).header(header).send({});
        });
})

app.get('/jwt/sign/:uid/:email', (req, res) => {
    const { uid } = req.params;
    const { email } = req.params;

    let token = jwt.sign({ uid: uid, email: email, }, "token", { expiresIn: 10 })
    console.log("Token generated!");

    res.send(token);
})

app.get('/mmi', (req, res) => {
    axios
        .get('http://www.tickertape.in/market-mood-index')
        .then(answer => {
            res.status(200).header(header).send(answer.data);
        })
        .catch(error => {
            console.error("Resource not found!\n");
        });
})

app.get('/trend/:trend', (req, res) => {
    const { trend } = req.params;
    axios
        .get('https://www1.nseindia.com/live_market/dynaContent/live_analysis/' + trend.toLowerCase() + 's/nifty' + trend + 's1.json')
        .then(answer => {
            res.status(200).header(header).send(answer.data);
        })
        .catch(error => {
            console.log("Unable to fetch trend\n");
            res.status(200).header(header).send({});
        });
})

app.get('/topindices', (req, res) => {
    axios
        .get('https://quotes-api.tickertape.in/quotes?sids=.NSEI,.NIFTYIT,.NSEBANK,.NIFTYFMCG,.NIPHARM')
        .then(result => {
            let response =
            {
                "N50": {
                    "value": result.data["data"][0]["price"],
                    "perChg": result.data["data"][0]["change"] * 100 / result.data["data"][0]["c"]
                },
                "NIT": {
                    "value": result.data["data"][1]["price"],
                    "perChg": result.data["data"][1]["change"] * 100 / result.data["data"][1]["c"]
                },
                "NBank": {
                    "value": result.data["data"][2]["price"],
                    "perChg": result.data["data"][2]["change"] * 100 / result.data["data"][2]["c"]
                },
                "NFMCG": {
                    "value": result.data["data"][3]["price"],
                    "perChg": result.data["data"][3]["change"] * 100 / result.data["data"][3]["c"]
                },
                "NPharma": {
                    "value": result.data["data"][4]["price"],
                    "perChg": result.data["data"][4]["change"] * 100 / result.data["data"][4]["c"]
                }
            }
            // console.log(response);
            res.status(200).header(header).send(response);
        })
        .catch(error => {
            console.error("Unable to fetch Nifty data\n");
            res.status(200).header(header).send({});
        });

});





// app.get('/topindices', (req, res) => {
//     var requestArray = [
//         { url: 'https://api.bseindia.com/RealTimeBseIndiaAPI/api/GetSensexData/w' },
//         { url: 'https://quotes-api.tickertape.in/quotes?sids=.NSEI' },
//         { url: 'https://quotes-api.tickertape.in/quotes?sids=.NIFTYIT' },
//         { url: 'https://quotes-api.tickertape.in/quotes?sids=.NSEBANK' },
//         { url: 'https://quotes-api.tickertape.in/quotes?sids=.NIFTYFMCG' },
//         { url: 'https://quotes-api.tickertape.in/quotes?sids=.NIPHARM' },
//     ];

//     let getApi = function (opt, callback) {
//         request(opt, (err, response, body) => {

//             callback(err, JSON.parse(body));
//         });
//     };

//     const functionArray = requestArray.map((opt) => {
//         return (callback) => getApi(opt, callback);
//     });

//     async.parallel(
//         functionArray, (error, result) => {
//             if (error) {
//                 console.error("Unable to fetch indices: " + error);
//                 res.status(200).header(header).send({});
//             } else {
//                 console.log("Fetched indices");
//                 let response =
//                 {
//                     "Sensex": {
//                         "value": result[0][0]["ltp"],
//                         "perChg": result[0][0]["chg"]
//                     },
//                     "N50": {
//                         "value": result[1]["data"][0]["price"],
//                         "perChg": result[1]["data"][0]["change"]
//                     },
//                     "NIT": {
//                         "value": result[2]["data"][0]["price"],
//                         "perChg": result[2]["data"][0]["change"]
//                     },
//                     "NBank": {
//                         "value": result[3]["data"][0]["price"],
//                         "perChg": result[3]["data"][0]["change"]
//                     },
//                     "NFMCG": {
//                         "value": result[4]["data"][0]["price"],
//                         "perChg": result[4]["data"][0]["change"]
//                     },
//                     "NPharma": {
//                         "value": result[5]["data"][0]["price"],
//                         "perChg": result[5]["data"][0]["change"]
//                     }
//                 }
//                 res.status(200).header(header).send(response);
//             }
//         });
// })

app.get('/', (req, res) => {
    res.status(200).header(header).send("Welcome to StockIn server!");
})

// app.get('/jwt/verify', (req, res) => {
//     const token = req.headers["token"];

//     jwt.verify(token, "token", async (error, data) => {
//         if (error) {
//             console.log("Token is expired");
//             res.send("Expired");
//         }
//         else {
//             console.log("Token is alive");
//             res.send("Alive")
//         }
//     })

// })




////////////
//        //
//   PUT  //
//        //
////////////

// app.put('/firebase/:email/:watchlist', (req, res) => {
//     const { email } = req.params;
//     const { watchlist } = req.params;

//     let obj = {};
//     obj[watchlist] = "Stock watchlisted";

//     database.ref(email + "/watchlist").update(obj)
//         .then(() => {
//             console.log("Stock " + watchlist + " watchlisted");
//             res.status(202).send("Data accepted!");
//         })
//         .catch((error) => {
//             console.log("Error: " + error);
//             res.status(500).send("Error in updating!");
//         });
// });

app.put('/firebase/:email/:mode/:code/:byPrice/:qty', (req, res) => {
    const { email } = req.params;
    const { mode } = req.params;
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
                oldByPrice = parseFloat(data.byPrice);
                oldQty = parseFloat(data.qty);
            }
            byPrice = parseFloat(byPrice);
            qty = parseFloat(qty);

            // console.log(typeof byPrice);
            // console.log(typeof qty);
            // console.log(typeof oldByPrice);
            // console.log(typeof oldQty);

            console.log("Old byPrice: " + oldByPrice);
            console.log("Old qty: " + oldQty);
            console.log("New byPrice: " + byPrice);
            console.log("New qty: " + qty);
            console.log("Mode: " + mode);

            if (mode == "Buy") {
                if (oldQty != 0) {
                    byPrice = ((oldByPrice * oldQty) + (byPrice * qty)) / (oldQty + qty);
                    qty = oldQty + qty;
                }

                var obj = {
                    "byPrice": byPrice,
                    "qty": qty
                };

                database.ref(email + "/" + code).update(obj)
                    .then(() => {
                        console.log("Stock updated");
                        res.status(202).header(header).send("Data accepted!");
                    })
                    .catch((error) => {
                        console.log("Error: " + error);
                        res.status(500).header(header).send("Error in updating!");
                    });
            }
            else if (mode == "Sell") {
                if (oldQty > qty) {
                    qty = oldQty - parseFloat(qty);

                    var obj = {
                        "byPrice": byPrice,
                        "qty": qty
                    };

                    database.ref(email + "/" + code).update(obj)
                        .then(() => {
                            console.log("Stock updated");
                            res.status(202).header(header).send("Data accepted!");
                        })
                        .catch((error) => {
                            console.log("Error: " + error);
                            res.status(500).header(header).send("Error in updating!");
                        });
                }
                if (oldQty == qty) {
                    database.ref(email + "/" + code).remove()
                        .then(() => {
                            console.log("Stock removed");
                            res.status(202).header(header).send("Stock deleted!");
                        })
                        .catch((error) => {
                            console.log("Error: " + error);
                            res.status(500).header(header).send("Error in updating!");
                        });
                }
            }





        })
        .catch((error) => {
            console.log("Error: " + error);
            res.status(500).header(header).send("Error in getting data");
        })
});




////////////
//        //
//  POST  //
//        //
////////////

app.post('/firebase/:email', (req, res) => {
    const { email } = req.params;

    database.ref(email).get()
        .then((snapshot) => {
            if (snapshot.exists()) {
                console.log("Account already exists");
                res.status(409).header(header).send("Account already exists");
            }
            else {
                console.log("Account does not exist: " + email);
                database.ref(email).set({
                    "Hello": "there!"
                })
                    .then(() => {
                        console.log("New user added");
                        res.status(201).header(header).send("Account created!");
                    })
                    .catch((error) => {
                        console.log("An error occured: " + error);
                        res.status(500).header(header).send("Error in creating account!");
                    });
            }
        })
        .catch((error) => {
            console.log("An error occured: " + error);
            res.status(500).header(header).send("Error in getting account!");
        })
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
            console.log("Account " + email.replace("_", ".") + " deleted!");
            res.status(200).header(header).send("Account deleted!");
        })
        .catch((error) => {
            console.log("Error in deleting: " + error);
            res.status(500).header(header).send("Error in deleting account!");
        })
});

// app.delete('/firebase/:email/:watchlist', (req, res) => {
//     const { email } = req.params;
//     const { watchlist } = req.params;

//     database.ref(email + "/watchlist/" + watchlist).remove()
//         .then(() => {
//             console.log("Stock " + watchlist + " removed from watchlist!");
//             res.status(200).header(header).send("Watchlist removed");
//         })
//         .catch((error) => {
//             console.log("Error in deleting: " + error);
//             res.status(500).send("Error in deleting account!");
//         })
// });
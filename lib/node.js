const express = require('express');
const axios = require('axios');
const app = express()
const port = 80


app.get('/stock/:key/:range/:interval', (req, res) => {
    const { key } = req.params;
    const { range } = req.params;
    const { interval } = req.params;
    console.log("Received key: " + key);
    console.log("Received range: " + range);
    console.log("Received interval: " + interval);

    axios
        .get('https://query1.finance.yahoo.com/v8/finance/chart/' + key + '?region=IN&lang=en-US&comparisons=&includePrePost=false&interval=' + interval + '&useYfid=true&range=' + range + '&corsDomain=finance.yahoo.com&.tsrc=finance')
        .then(answer => {
            console.log(`statusCode: ${answer.status}\n`);
            res.send(answer.data.chart.result[0]);
        })
        .catch(error => {
            console.error("Request failed with status code 422");
            console.error("Try changing range")
        });
})

app.listen(port, () => {
    console.log(`Example app listening on port ${port}`)
})
/**
 * Created by Michael on 11/14/2016.
 */

var express = require('express');
var fs = require('fs');
var https = require('https');

var useAuth = true;
var app = express();

var options = {
    key: fs.readFileSync('certs/server-key.pem'),
    cert: fs.readFileSync('certs/server-crt.pem'),
    ca: fs.readFileSync('certs/ca-crt.pem'),
    crl: fs.readFileSync('certs/ca-crl.pem'),
};

app.use(function (req, res, next) {
    var log = new Date() + ' ' + req.connection.remoteAddress + ' ' + req.method + ' ' + req.url;
    var cert = req.socket.getPeerCertificate();
    if (cert.subject) {
        log += ' ' + cert.subject.CN;
    }
    console.log(log);
    next();
});


if (useAuth) {
    //cert authorization
    app.use(function (req, res, next) {
        if (!req.client.authorized) {
            return res.status(401).send('User is not authorized');
        }
        next();
    });

    options.requestCert = true;
    options.rejectUnauthorized = false;
}

app.use(function (req, res, next) {
    res.writeHead(200);
    res.end("hello world\n");
    next();
});

var listener = https.createServer(options, app).listen(4433, function () {
    console.log('Express HTTPS server listening on port ' + listener.address().port);
});
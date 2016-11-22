# https-demo
node.js/express demonstration of https and client auth

This was inspired by the excellent article [HTTPS Authorized Certs with Node.js](https://engineering.circle.com/https-authorized-certs-with-node-js-315e548354a2#.qmm5jzi7f).  Code is similar to the sample but incorporates Express.  Commands were distilled into two bash shell scripts.

### Set up and run the demo
```
# Install dependencies
npm install
cd certs
# Create all necessary certificates.  Dig into the scripts to learn more.
./init.sh
# Start 'er up.
cd ..
node app
```
### Testing with curl
```
# Access the site using the client certificate created above.
curl -v -s -k --key snort-key.pem --cert snort-crt.pem https://localhost:4433
```

### Testing with a browser
1. Add the client pfx file to your certificate store.  Because you're using a newly created CA, you'll probably need to add that pfx as well.
2. Browse to https://localhost:4433.  
3. You should be presented with a dialog box.  Choose the client certificate.

Note that if you change the certificate, you will need to completely close Chrome (and possibly need to kill the task) in order to see the dialog again.

Certificate Revocation is left as a future exercise. 



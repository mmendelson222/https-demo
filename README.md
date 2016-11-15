# https-demo
node.js/express demonstration of https and client auth

This was inspired by the excellent article [HTTPS Authorized Certs with Node.js](https://engineering.circle.com/https-authorized-certs-with-node-js-315e548354a2#.qmm5jzi7f).  Code is similar to the sample but incorporates Express. 

Commands were distilled into two bash shell scripts.  To run the demo: 
```
# Install dependencies
npm install
cd certs
# Create a CA and server certificate.
./create_ca_server.sh
# Create a client certificate called "snort".
./create_client.sh snort
# Start 'er up.
node app
```
To test:
```
# Access the site using the client certificate created above.
curl -v -s -k --key snort-key.pem --cert snort-crt.pem https://localhost:4433
```

Certificate Revocation is left as a future exercise. 
 


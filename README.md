# https-demo
node.js/express demonstration of https and client auth

This was inspired by the excellent article [HTTPS Authorized Certs with Node.js](https://engineering.circle.com/https-authorized-certs-with-node-js-315e548354a2#.qmm5jzi7f).  Code is similar to the sample but incorporates Express. 

Commands were distilled into two bash shell scripts.  To run the demo: 
```
npm install
cd certs
./create_ca_server.sh
./create_client.sh snort
curl -v -s -k --key snort-key.pem --cert snort-crt.pem https://localhost:4433
```
Certificate Revocation is left as a future exercise. 
 


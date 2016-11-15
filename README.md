# https-demo
node.js/express demonstration of https and client auth

Here are most of the commands run to create the certs.  This all came from an excellent article [HTTPS Authorized Certs with Node.js](https://engineering.circle.com/https-authorized-certs-with-node-js-315e548354a2#.qmm5jzi7f).  Code is similar to the sample but incorporates Express. 

```
curl -v -s -k https://localhost:3000
curl -v -s -k https://localhost:3000
openssl req -new -x509 -days 9999 -config ca.cnf -keyout ca-key.pem -out ca-crt.pem
openssl req -new -config server.cnf -key server-key.pem -out server-csr.pem
openssl genrsa -out server-key.pem 4096
openssl req -new -config server.cnf -key server-key.pem -out server-csr.pem
openssl x509 -req -extfile server.cnf -days 999 -passin "pass:password" -in server-csr.pem -CA ca-crt.pem -CAkey ca-key.pem -CAcreateserial -out server-crt.pem

openssl req -new -x509 -days 9999 -config ca.cnf -keyout client-key.pem -out client-crt.pem
openssl x509 -req -extfile server.cnf -days 999 -passin "pass:password" -in server-csr.pem -CA client-crt.pem -CAkey client-key.pem 

openssl genrsa -out client1-key.pem 4096
openssl genrsa -out client2-key.pem 4096
openssl req -new -config client1.cnf -key client1-key.pem -out client1-csr.pem
openssl req -new -config client2.cnf -key client2-key.pem -out client2-csr.pem
openssl req -new -config client2.cnf -key client2-key.pem -out client2-csr.pem
openssl x509 -req -extfile client1.cnf -days 999 -passin "pass:password" -in client1-csr.pem -CA ca-crt.pem -CAkey ca-key.pem -CAcreateserial -out client1-crt.pem
openssl x509 -req -extfile client2.cnf -days 999 -passin "pass:password" -in client2-csr.pem -CA ca-crt.pem -CAkey ca-key.pem -CAcreateserial -out client2-crt.pem
openssl verify -CAfile ca-crt.pem client1-crt.pem

curl -v -s -k --key client-key.pem --cert client-crt.pem https://localhost:4433

touch ca-database.txt
openssl ca -revoke client2-crt.pem -keyfile ca-key.pem -config ca.cnf -cert ca-crt.pem -passin 'pass:password'
openssl ca -keyfile ca-key.pem -cert ca-crt.pem -config ca.cnf -gencrl -out ca-crl.pem -passin 'pass:password'
curl -v -s -k --key client2-key.pem --cert client2-crt.pem https://localhost:4433
```

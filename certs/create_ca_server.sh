#!/bin/bash
echo create new CA based on config
openssl req -new -x509 -days 9999 -config ca.cnf -keyout ca-key.pem -out ca-crt.pem
echo generating private key for server
openssl genrsa -out server-key.pem 4096
echo generating a signing request
openssl req -new -sha256 -config server.cnf -key server-key.pem -out server-csr.pem
echo signing the request
openssl x509 -req -extfile server.cnf -days 999 -passin "pass:password" -in server-csr.pem -CA ca-crt.pem -CAkey ca-key.pem -CAcreateserial -out server-crt.pem

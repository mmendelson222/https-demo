#!/bin/bash
export CA_NAME=ca

echo create new CA based on config
openssl req -new -x509 -days 9999 -config $CA_NAME.cnf -keyout $CA_NAME-key.pem -out $CA_NAME-crt.pem

echo generating private key for server
openssl genrsa -out server-key.pem 4096

echo generating a signing request
openssl req -new -sha256 -config server.cnf -key server-key.pem -out server-csr.pem

echo signing the request
openssl x509 -req -extfile server.cnf -days 999 -passin "pass:password" -in server-csr.pem -CA $CA_NAME-crt.pem -CAkey $CA_NAME-key.pem -CAcreateserial -out server-crt.pem

echo 'create pfx file for windows browser'
openssl pkcs12 -export -out $CA_NAME.pfx -inkey $CA_NAME-key.pem -in $CA_NAME-crt.pem -passin "pass:password" -passout "pass:"


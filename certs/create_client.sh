#!/bin/bash
if [ -z "$1" ]
  then
    echo "Need single argument - new cert name (no spaces)"
	exit 1
fi
echo create client cert
openssl genrsa -out $1-key.pem 4096

echo create temporary config file
sed "s/replace_me/$1/g" client-template.cnf > $1.cnf

echo create certificate signing request
openssl req -new -sha256 -config $1.cnf -key $1-key.pem -out $1-csr.pem 

echo sign the new cert
openssl x509 -req -extfile $1.cnf -days 999 -passin "pass:password" -in $1-csr.pem -CA ca-crt.pem -CAkey ca-key.pem -CAcreateserial -out $1-crt.pem 

echo remove temporary config file
rm $1.cnf

echo verify
openssl verify -CAfile ca-crt.pem $1-crt.pem

echo create pfx file for windows (with no pw)
openssl pkcs12 -export -out $1.pfx -inkey $1-key.pem -in $1-crt.pem -passout "pass:"


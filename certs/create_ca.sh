#!/bin/bash
if [ -z "$1" ]
  then
    echo "Need single argument - ca name (e.g. ca)"
	exit 1
fi
export CA_NAME=$1

echo create temporary config file
sed "s/replace_me/$CA_NAME/g" ca-template.cnf > $CA_NAME.cnf

echo create new CA based on config
openssl req -new -x509 -days 9999 -config $CA_NAME.cnf -keyout $CA_NAME-key.pem -out $CA_NAME-crt.pem

echo remove temporary config file
rm $CA_NAME.cnf

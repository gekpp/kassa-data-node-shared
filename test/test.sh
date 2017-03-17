#!/bin/bash

source ./setenv.sh || exit 1

sleep 1

VERBOSER='-v'

curl $VERBOSE \
    -H "Content-Type: application/json" \
    -X POST \
    -d '{"name":"microCloud","vendor_code":"12341231"}' \
    http://localhost:$PORT/products

curl $VERBOSE \
    -H "Content-Type: application/json" \
    -X POST \
    -d '{"name":"tablet","vendor_code":"12341231"}' \
    http://localhost:${PORT}/products


# GET LIST
curl $VERBOSE "localhost:${PORT}/products"
curl $VERBOSE "localhost:${PORT}/products/1"
curl $VERBOSE "localhost:${PORT}/products/2"



#PUT
curl $VERBOSE \
    -H "Content-Type: application/json" \
    -X PUT \
    -d '{"name":"SuperCloud","vendor_code":"12341231"}' \
    http://localhost:$PORT/products/1


#DELETE
curl -v -X DELETE localhost:8080/products/1

#DELETE absent product results 404
curl -v \
    -H "Content-Type: application/json" \
    -X DELETE \
    http://localhost:$PORT/products/128



docker rm -f ${DOCKER_NAME}
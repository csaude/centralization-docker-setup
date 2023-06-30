#!/bin/sh

dockerize -wait-retry-interval 5s -timeout 120s -wait $HAPI_FHIR_URL -wait tcp://es-dev:9200 node lib/app.js

#!/bin/bash

envsubst < ~/demo/manifest-files/codebeamer-all-in-one.yaml.envsubst > ~/demo/manifest-files/codebeamer-all-in-one.yaml
rm ~/demo/manifest-files/codebeamer-all-in-one.yaml.envsubst
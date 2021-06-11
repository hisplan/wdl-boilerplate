#!/usr/bin/env bash

java -jar ~/Applications/womtool.jar \
    validate \
    HelloWorld.wdl \
    --inputs ./configs/HelloWorld.inputs.json

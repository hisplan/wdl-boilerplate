#!/usr/bin/env bash

java -jar ~/Applications/womtool.jar \
    validate \
    Main.wdl \
    --inputs ./configs/Main.inputs.json

#!/usr/bin/env bash

java -jar ~/Applications/womtool.jar \
    validate \
    Main.wdl \
    --inputs Main.inputs.json

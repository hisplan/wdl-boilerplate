version 1.0

import "modules/HelloWorld.wdl" as HelloWorld

workflow HelloWorld {

    input {
        String name = name
    }

    call HelloWorld.Say {
        input:
            name = name
    }

    call HelloWorld.SayToFile {
        input:
            message = Say.out
    }

    output {
        String outString = Say.out
        File outFile = SayToFile.out
    }
}
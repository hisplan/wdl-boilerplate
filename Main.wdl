version 1.0

import "modules/HelloWorld.wdl" as HelloWorld

workflow Main {

    input {
        String name = name
    }

    call HelloWorld.Say {
        input:
            name = name
    }

    call HelloWorld.Repeat {
        input:
            message = Say.out
    }

    output {
        String outSay = Say.out
        String outRepeat = Repeat.out
    }
}

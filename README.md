# Cromwell+WDL Boilerplate

## Outline

1. Hello World!
1. Structure
1. Naming Conventions
1. Modular Design
1. Your First Workflow
1. Testing
1. Known Issues

## Hello World!

The boilerplate comes with an example workflow called `HelloWorld`. Run this workflow first on your workflow system to verify your environment is ready.

```bash
$ ./submit.sh \
    -k ~/keys/secrets-aws.json \
    -i ./configs/Main.inputs.json \
    -l ./configs/Main.labels.aws.json \
    -o Main.options.aws.json
```

- `secrets-aws.json`: contains your credentials to access the workflow system.

## Structure

```
.
├── Main.deps.zip
├── Main.options.aws.json
├── Main.options.gcp.json
├── Main.wdl
├── README.md
├── configs
│   ├── Main.inputs.json
│   ├── Main.labels.aws.json
│   └── Main.labels.gcp.json
├── modules
│   └── HelloWorld.wdl
├── submit.sh
├── tests
│   ├── run-all-tests.sh
│   ├── run-test.sh
│   ├── test.HelloWorld.inputs.json
│   ├── test.HelloWorld.wdl
│   ├── test.labels.json
│   ├── validate.sh
│   └── zip-deps.sh
└── validate.sh
```

### `configs`

A directory where job configurations will be placed.

### `modules`

A directory where subworkflows will be placed.

### `tests`

A directory where tests for subworkflows will be placed.

## Naming Conventions

- Use pascal case for the main workflow and subworkflow names and file names.
- Add postfix `.inputs.json` and `.labels.json` for job configurations.

## Modular Design

The boilerplate comes with the HelloWorld example which takes your name as input and outputs your name 1) as a string and 2) as a file. `Main.wdl` is the main workflow. `modules/HelloWorld.wdl` is the subworkflow.

## Your First Workflow

Before you do anything, it is recommended to change `Main` to something else. For example, if you are building a Cell Hashing pipeline, you probably want to replace the name `Main` to `CellHashing`.

These are the files to be updated:

- `Main.wdl`
- `submit.sh`
- `validate.sh`
- `./configs/Main.inputs.json`
- `./configs/Main.labels.aws.json`
- `./configs/Main.labels.gcp.json`
- `./tests/run-test.sh`
- `./tests/zip-deps.sh`

## Testing

Currently, it's not really designed for unit testing, rather this will allow you to verify if your WDL files are written syntactically right.

```bash
$ cd tests
$ ./validate.sh
```

If you have added new subworkflows, make sure to include them in `validate.sh` before running it:

```bash
modules="MyNewSubWorkflow HelloWorld"
```

Also, another thing you can do is actually running your subworkflow(s) on the workflow system.

```bash
$ cd tests
$ ./run-all-tests.sh -k ~/keys/secrets-aws.json
```

Again, if you have added new subworkflows, make sure to include them in `run-all-tests.sh` before running it:

```bash
modules="MyNewSubWorkflow HelloWorld"
```

You can also run an individual subworkflow separately:

```bash
$ cd tests
$ ./run-test.sh -k ~/keys/secrets-aws.json -m HelloWorld
```

## Known Issues

The following three doesn't work currently (in `Main.options.*.json`)

```json
{
    "final_workflow_outputs_dir": "s3://dp-lab-batch/cromwell-execution/_outputs/Main/results",
    "final_workflow_log_dir": "s3://dp-lab-batch/cromwell-execution/_outputs/Main/workflow-logs",
    "final_call_logs_dir": "s3://dp-lab-batch/cromwell-execution/_outputs/Main/call-logs"
}
```

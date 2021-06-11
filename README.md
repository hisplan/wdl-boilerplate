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
    -i ./configs/HelloWorld.inputs.json \
    -l ./configs/HelloWorld.labels.aws.json \
    -o HelloWorld.options.aws.json
```

- `secrets-aws.json`: contains your credentials to access the workflow system.

## Structure

```
.
├── HelloWorld.deps.zip
├── HelloWorld.options.aws.json
├── HelloWorld.options.gcp.json
├── HelloWorld.wdl
├── README.md
├── configs
│   ├── HelloWorld.inputs.json
│   ├── HelloWorld.labels.aws.json
│   └── HelloWorld.labels.gcp.json
├── modules
│   └── Greeter.wdl
├── submit.sh
├── tests
│   ├── run-all-tests.sh
│   ├── run-test.sh
│   ├── test.Greeter.inputs.json
│   ├── test.Greeter.wdl
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

The boilerplate comes with the HelloWorld example which takes your name as input and outputs your name 1) as a string and 2) as a file. `HelloWorld.wdl` is the main workflow. `./modules/Greeter.wdl` is the subworkflow. You can add additional subworkflows under the `modules` directory and call them from your main workflow (e.g. `HelloWorld.wdl`).

## Your First Workflow

Before you do anything, it is recommended to change `HelloWorld` to something else. For example, if you are building a Cell Hashing pipeline, you probably want to replace the name `HelloWorld` to `CellHashing`.

These are the files to be updated:

- `HelloWorld.wdl`
- `submit.sh`
- `validate.sh`
- `./configs/HelloWorld.inputs.json`
- `./configs/HelloWorld.labels.aws.json`
- `./configs/HelloWorld.labels.gcp.json`
- `./tests/run-test.sh`
- `./tests/zip-deps.sh`

## Testing

Currently, this is not really designed for unit testing, rather this will allow you to verify if your WDL files are written syntactically right.

```bash
$ cd tests
$ ./validate.sh
```

If you have added new subworkflows, make sure to include them in `validate.sh` before running it:

```bash
modules="MyNewSubWorkflow Greeter"
```

Also, another thing you can do is actually running your subworkflow(s) on the workflow system.

```bash
$ cd tests
$ ./run-all-tests.sh -k ~/keys/secrets-aws.json
```

Again, if you have added new subworkflows, make sure to include them in `run-all-tests.sh` before running it:

```bash
modules="MyNewSubWorkflow Greeter"
```

You can also run an individual subworkflow separately:

```bash
$ cd tests
$ ./run-test.sh -k ~/keys/secrets-aws.json -m Greeter
```

## Known Issues

The following three doesn't work currently (in `HelloWorld.options.*.json`)

```json
{
    "final_workflow_outputs_dir": "s3://dp-lab-batch/cromwell-execution/_outputs/HelloWorld/results",
    "final_workflow_log_dir": "s3://dp-lab-batch/cromwell-execution/_outputs/HelloWorld/workflow-logs",
    "final_call_logs_dir": "s3://dp-lab-batch/cromwell-execution/_outputs/HelloWorld/call-logs"
}
```

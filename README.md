# Cromwell+WDL Boilerplate

## Outline

1. Hello World!
1. Structure
1. Naming Conventions
1. Modular Design
1. Development Steps
1. Your First Workflow
1. Testing
1. Known Issues

## Setup

The boilerplate is a part of SCING (Single-Cell pIpeliNe Garden; pronounced as "sing" /siŋ/). For setup, please refer to [this page](https://github.com/hisplan/scing). All the instructions below is given under the assumption that you have already configured SCING + JRE or JDK in your environment.

However, with small changes in the instructions and code, you should be able to use this boilerplate for any Cromwell/WDL-based workflow system.

## Hello World!

The boilerplate comes with an example workflow called `HelloWorld`. Let's run this workflow first on your workflow system to verify your environment is ready.

Download the boilerplate and extract it to a new directory called `wdl-HelloWorld`:

```bash
wget https://github.com/hisplan/wdl-boilerplate/archive/refs/tags/v0.0.13.tar.gz -O wdl-boilerplate.tar.gz
mkdir -p wdl-HelloWorld && tar xvzf wdl-boilerplate.tar.gz -C wdl-HelloWorld --strip-components 1
```

```bash
cd wdl-HelloWorld
```

Open `configs/HelloWorld.inputs.json` and change the `HelloWorld.name` value to your real name (e.g. `Jaeyoung`):

```json
{
    "HelloWorld.name": "Jaeyoung"
}
```

Open `configs/HelloWorld.labels.aws.json` and change the `destination` value to `s3://dp-lab-gwf-core/outputs/HelloWorld/$NAME` where `$NAME` should be replaced with your real name (e.g. `Jaeyoung`):

```
{
    "pipelineType": "HelloWorld",
    "project": "Test",
    "sample": "Test",
    "owner": "chunj",
    "destination": "s3://dp-lab-gwf-core/outputs/HelloWorld/Jaeyoung/",
    "transfer": "-",
    "comment": ""
}
```

Activate the `scing` conda environment:

```
conda activate scing
```

Submit a HelloWorld job to the workflow system:

```bash
./submit.sh \
    -k ~/keys/cromwell-secrets.json \
    -i ./configs/HelloWorld.inputs.json \
    -l ./configs/HelloWorld.labels.aws.json \
    -o HelloWorld.options.aws.json
```

where `cromwell-secrets.json` is your secrets file that contains your credentials and server address.

## Structure

```
.
├── configs
│   ├── HelloWorld.inputs.json
│   ├── HelloWorld.labels.aws.json
│   ├── HelloWorld.labels.gcp.json
│   ├── template.inpus.json
│   └── template.labels.json
├── modules
│   └── Greeter.wdl
├── tests
│   ├── run-all-tests.sh
│   ├── run-test.sh
│   ├── test.Greeter.inputs.json
│   ├── test.Greeter.wdl
│   ├── test.labels.json
│   ├── validate.sh
│   └── zip-deps.sh
├── HelloWorld.deps.zip
├── HelloWorld.options.aws.json
├── HelloWorld.options.gcp.json
├── HelloWorld.wdl
├── README.md
├── init.sh
├── make-deployable.sh
├── submit.sh
└── validate.sh
```

File/Directory         | Description
---------------------- | -------------------------------------------------------------
`configs`              | Directory where job configurations should be placed
`modules`              | Directory where subworkflows should be placed
`tests`                | Directory where tests for subworkflows should be placed
`HelloWorld.wdl`       | Main workflow
`HelloWorld.deps.zip`  | Packaged/compressed subworkflows (`modules/*`)
`submit.sh`            | Script for submitting a job to the workflow system

## Naming Conventions

- Use pascal case for the main workflow, subworkflow name, task name, and file name (e.g. `HelloWorld`).
- Use camel case for variables (e.g. `helloWorld`).
- Add postfix `.inputs.json` and `.labels.json` for job configurations.

## Modular Design

The boilerplate comes with the HelloWorld example which takes your name as input and outputs your name 1) as a string and 2) as a file. `HelloWorld.wdl` is the main workflow. `./modules/Greeter.wdl` is the subworkflow. You can add additional subworkflows under the `modules` directory and call them from your main workflow (e.g. `HelloWorld.wdl`).

When you finish writing your subworkflows, you must run `tests/zip-deps.sh` which packages all your subworkflows into a single deployable file.

## Development Steps

1. Write subworkflows (under the `modules` directory)
1. Create a test workflow that can test your subworkflows (under the `tests` directory)
1. Validate each subworkflow (`tests/validate.sh`)
1. Test each subworkflow by actually running them on the workflow system (`tests/run-test.sh`)
1. Package subworkflows into a deployable file (`tests/zip-deps.sh`)
1. Write the main workflow.
1. Validate the main workflow.
1. Create a job input/label file (under the `configs` directory)

## Your First Workflow

Before you do anything, you should change `HelloWorld` to something else. For example, if you are building a Cell Hashing pipeline, you probably want to replace the name `HelloWorld` to `CellHashing`.

These are the files to be updated:

- `./validate.sh`
- `./tests/zip-deps.sh`
- `./tests/run-test.sh`
- `./submit.sh`
- `./HelloWorld.wdl`
- `./configs/HelloWorld.labels.gcp.json`
- `./configs/HelloWorld.labels.aws.json`
- `./configs/HelloWorld.inputs.json`

You should also change the file names as well (e.g. `HelloWorld.wdl` to `CellHashing.wdl`)

Renaming will be a tedious thing to do, so you can try out the auto-rename tool (experimental):

```bash
./init.sh -n CellHashing
```

Without the `-e` flag, it will run as a test (i.e. dry run)

## Testing

Currently, this is not really designed for unit testing (TBD), rather this will allow you to verify if your WDL files are written syntactically and semantically right.

```bash
cd tests
./validate.sh
```

If you have added new subworkflows, make sure to include them in `validate.sh` before running it:

```bash
modules="MyNewSubWorkflow Greeter"
```

Also, another thing you can do is running your subworkflow(s) on the workflow system.

```bash
cd tests
./run-all-tests.sh -k ~/keys/cromwell-secrets.json
```

Again, if you have added new subworkflows, make sure to include them in `run-all-tests.sh` before running it:

```bash
modules="MyNewSubWorkflow Greeter"
```

You can also run an individual subworkflow separately:

```bash
cd tests
./run-test.sh -k ~/keys/cromwell-secrets.json -m Greeter
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

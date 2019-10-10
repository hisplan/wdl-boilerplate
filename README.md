# Cromwell+WDL Boilerplate

Change `Main` to something else.

## Fix

The following three doesn't work currently (`Main.options.json`)

```json
{
    "final_workflow_outputs_dir": "s3://dp-lab-batch/cromwell-execution/_outputs/Main/results",
    "final_workflow_log_dir": "s3://dp-lab-batch/cromwell-execution/_outputs/Main/workflow-logs",
    "final_call_logs_dir": "s3://dp-lab-batch/cromwell-execution/_outputs/Main/call-logs"
}
```


# AWS SSM Module

This module manages the creation of AWS Systems Manager (SSM) parameters, enables Session Manager logging, and optionally creates a patch baseline for managing updates to instances.

## Features

- Create and manage SSM parameters.
- Enable Session Manager logging to CloudWatch Logs and S3.
- Configure a patch baseline for managing instance patches (optional).

---

## Resources

### SSM Parameters
This module creates SSM parameters as defined in the `ssm_parameters` variable. Each parameter includes:
- Name
- Type
- Value
- Description
- Tier (Standard/Advanced)

### Session Manager Logging
Enables logging for Session Manager, ensuring that logs are sent to CloudWatch Logs and S3. Uses an AWS SSM Document to configure logging.

### Patch Baseline (Optional)
Creates a patch baseline for managing updates to instances. The baseline is configured with approval rules and filters.

---

## Inputs

| Variable                        | Description                                            | Type            | Default          | Required |
|---------------------------------|--------------------------------------------------------|-----------------|------------------|----------|
| `environment`                   | The environment (e.g., dev, staging, prod).           | `string`        |                  | Yes      |
| `ssm_parameters`                | Map of SSM parameters to create.                      | `map(object)`   | `{}`             | No       |
| `tags`                          | Tags to apply to all resources.                       | `map(string)`   | `{}`             | No       |
| `enable_patch_baseline`         | Whether to create a patch baseline.                   | `bool`          | `false`          | No       |
| `patch_baseline_operating_system` | Operating system for the patch baseline.              | `string`        | `AMAZON_LINUX`   | No       |
| `patch_baseline_product`        | Product filter for the patch baseline.                | `list(string)`  | `["AmazonLinux2"]`| No       |
| `patch_approval_days`           | Number of days after release to approve patches.      | `number`        | `7`              | No       |

---

## Outputs

| Output                       | Description                                      |
|------------------------------|--------------------------------------------------|
| `ssm_parameter_arns`         | ARNs of the created SSM parameters.             |
| `ssm_parameter_names`        | Names of the created SSM parameters.            |
| `session_manager_document_name` | Name of the Session Manager document.          |
| `patch_baseline_arn`         | ARN of the Patch Baseline (if created).         |

---

## Example Usage

```hcl
module "ssm" {
  source = "./aws_ssm_module"

  environment = "prod"

  ssm_parameters = {
    "/example/parameter" = {
      type        = "String"
      value       = "ExampleValue"
      description = "An example parameter"
    }
  }

  enable_patch_baseline = true
  patch_baseline_operating_system = "AMAZON_LINUX"
  patch_baseline_product = ["AmazonLinux2"]
  patch_approval_days = 7

  tags = {
    Project = "ExampleProject"
    Team    = "DevOps"
  }
}
```

## Notes
- The `patch_baseline` resource is optional and controlled via the `enable_patch_baseline` variable.
- Ensure the `ssm_parameters` variable is configured with appropriate values for your use case.

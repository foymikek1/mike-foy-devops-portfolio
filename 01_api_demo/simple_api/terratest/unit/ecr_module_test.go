package unit

import (
  "testing"

  "github.com/gruntwork-io/terratest/modules/terraform"
  "github.com/stretchr/testify/assert"
)

func TestEcrModulePlan(t *testing.T) {
  t.Parallel()

  opts := &terraform.Options{
    TerraformDir: "../../infra/modules/ecr",
    PlanFilePath: "plan.tfplan",
    Vars: map[string]interface{}{
      "name":   "simple-api",
      "region": "us-east-1",
    },
  }

  planStruct := terraform.InitAndPlanAndShowWithStruct(t, opts)

  // Ensures the ECR repo resource is in the plan
  assert.Contains(t, planStruct.ResourcePlannedValuesMap, "aws_ecr_repository.repository")
}

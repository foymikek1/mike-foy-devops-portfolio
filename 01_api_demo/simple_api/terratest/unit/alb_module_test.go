package unit

import (
  "testing"

  "github.com/gruntwork-io/terratest/modules/terraform"
  "github.com/stretchr/testify/assert"
)

func TestAlbModulePlan(t *testing.T) {
  t.Parallel()

  opts := &terraform.Options{
    TerraformDir:    "../../infra/modules/alb",
    PlanFilePath:    "plan.tfplan", // Tell terratest where to write the plan
    Vars: map[string]interface{}{
      "name":               "simple-api-alb",
      "subnet_ids":         []string{"subnet-01234567", "subnet-89abcdef"},
      "security_group_ids": []string{"sg-01234567"},
      "scheme":             "internet-facing",
      "region":             "us-east-1",
    },
  }

  // Init, plan (to plan.tfplan) and load into Go struct
  planStruct := terraform.InitAndPlanAndShowWithStruct(t, opts)

  // Grabs both the LB and its listener
  assert.Contains(t, planStruct.ResourcePlannedValuesMap, "aws_lb.alb")
  assert.Contains(t, planStruct.ResourcePlannedValuesMap, "aws_lb_listener.listener")
}

package unit

import (
  "testing"

  "github.com/gruntwork-io/terratest/modules/terraform"
  "github.com/stretchr/testify/assert"
)

func TestEcsClusterModulePlan(t *testing.T) {
  t.Parallel()

  opts := &terraform.Options{
    TerraformDir: "../../infra/modules/ecs-cluster",
    PlanFilePath: "plan.tfplan",
    Vars: map[string]interface{}{
      "cluster_name": "simple-api-cluster",
      "region":       "us-east-1",
    },
  }

  planStruct := terraform.InitAndPlanAndShowWithStruct(t, opts)

  // Confirms the ECS cluster is in the plan
  assert.Contains(t, planStruct.ResourcePlannedValuesMap, "aws_ecs_cluster.cluster")
}

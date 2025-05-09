package unit

import (
  "testing"
  "github.com/gruntwork-io/terratest/modules/terraform"
  "github.com/stretchr/testify/assert"
)

func TestEcsClusterModule(t *testing.T) {
  t.Parallel()

  opts := &terraform.Options{
    TerraformDir: "../modules/ecs-cluster",
    Vars: map[string]interface{}{
      "cluster_name": "simple-api-cluster",
    },
  }
  defer terraform.Destroy(t, opts)
  terraform.InitAndApply(t, opts)

  // Verifys the cluster name output matches what is configured
  clusterName := terraform.Output(t, opts, "cluster_name")
  assert.Equal(t, "simple-api-cluster", clusterName)
}

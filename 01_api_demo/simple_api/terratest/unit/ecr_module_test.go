package unit

import (
  "testing"
  "github.com/gruntwork-io/terratest/modules/terraform"
  "github.com/stretchr/testify/assert"
)

func TestEcrModule(t *testing.T) {
  t.Parallel()

  // Points at the ECR module folder
  opts := &terraform.Options{
    TerraformDir: "../modules/ecr",
    Vars: map[string]interface{}{
      // Minimal required var for module
      "name": "simple-api",
    },
  }

  // Clean up resources at the end
  defer terraform.Destroy(t, opts)

  // Init & apply only this module
  terraform.InitAndApply(t, opts)

  // Grabs the repository URL output
  repoURL := terraform.Output(t, opts, "repository_url")

  // Asserts it contains the expected AWS ECR domain
  assert.Contains(t, repoURL, ".dkr.ecr.", "ECR repo URL should be in AWS ECR")
}

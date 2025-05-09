package integration

import (
  "fmt"
  "testing"
  "net/http"
  "time"

  "github.com/gruntwork-io/terratest/modules/terraform"
  "github.com/stretchr/testify/assert"
)

func TestFullStack(t *testing.T) {
  t.Parallel()

  // Point at the root stack (where where each module is called)
  opts := &terraform.Options{
    TerraformDir: "../",
    // If other vars needed for future services (VPC IDs, DB URL, etc)
    Vars: map[string]interface{}{
      "image_url":             "123456789012.dkr.ecr.us-east-1.amazonaws.com/simple-api:latest",
      "postgresql_username":   "postgres",
      "postgresql_password":   "postgres",
      "postgresql_database":   "simple_api_dev",
    },
  }
  defer terraform.Destroy(t, opts)

  // Deploy everything
  terraform.InitAndApply(t, opts)

  // Grabs the ALB DNS name to test HTTP
  albDNS := terraform.Output(t, opts, "alb_dns_name")
  endpoint := fmt.Sprintf("http://%s/", albDNS)

  // Retrys GET for up to 2 minutes, in case startup takes a bit
  maxRetries := 20
  timeBetween := 6 * time.Second
  httpStatus := terraform.HttpGetWithRetry(t, endpoint, nil, maxRetries, timeBetween)

  // Expects at least a 200-series response
  assert.GreaterOrEqual(t, httpStatus, 200)
  assert.Less(t, httpStatus, 300)
}

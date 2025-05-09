package integration

import (
  "fmt"
  "testing"
  "time"

  "github.com/gruntwork-io/terratest/modules/terraform"
  http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
  "github.com/stretchr/testify/assert"
)

func TestFullStack(t *testing.T) {
  t.Parallel()

  // Points at the root infra folder (where each module is called)
  opts := &terraform.Options{
    TerraformDir: "../../infra",
    Vars: map[string]interface{}{
      "image_url":           "123456789012.dkr.ecr.us-east-1.amazonaws.com/simple-api:latest",
      "postgresql_username": "postgres",
      "postgresql_password": "postgres",
      "postgresql_database": "simple_api_dev",
    },
  }

  // Deploys the full stack and schedules cleanup
  terraform.InitAndApply(t, opts)
  defer terraform.Destroy(t, opts)

  // Grabs the ALB DNS name from outputs
  albDNS := terraform.Output(t, opts, "alb_dns_name")
  assert.NotEmpty(t, albDNS, "Expected alb_dns_name output to be non-empty")

  // Constructs the root endpoint URL
  endpoint := fmt.Sprintf("http://%s/", albDNS)

  // Polls the endpoint until HTTP 200 and body contains "OK"
  // Adds a nil for the TLS config (since this is plain HTTP)
  maxRetries := 20
  sleepBetween := 6 * time.Second
  http_helper.HttpGetWithRetry(t, endpoint, nil, 200, "OK", maxRetries, sleepBetween)
}

package unit

import (
  "testing"

  "github.com/gruntwork-io/terratest/modules/terraform"
  "github.com/stretchr/testify/assert"
)

func TestAlbModule(t *testing.T) {
  t.Parallel()

  // Points to ALB module folder
  opts := &terraform.Options{
    TerraformDir: "../modules/alb",
    Vars: map[string]interface{}{
      // Supplys the minimal required inputs for the ALB module
      "name":            "simple-api-alb",
      "subnet_ids":      []string{"subnet-01234567", "subnet-89abcdef"},
      "security_group_ids": []string{"sg-01234567"},
      "scheme":          "internet-facing",
    },
  }

  // Ensures destroy of the ALB after test
  defer terraform.Destroy(t, opts)

  // Init & apply only this ALB module
  terraform.InitAndApply(t, opts)

  // Grabs the ALB DNS name output
  albDNS := terraform.Output(t, opts, "alb_dns_name")
  // It should look like an AWS ALB DNS entry
  assert.Contains(t, albDNS, "elb.amazonaws.com", "ALB DNS name should include AWS ELB domain")

  // Grabs the ALB ARN output
  albArn := terraform.Output(t, opts, "alb_arn")
  // It should contain the word 'loadbalancer'
  assert.Contains(t, albArn, "loadbalancer", "ALB ARN must identify a load balancer")

  // Grabs the ALB scheme output
  albScheme := terraform.Output(t, opts, "alb_scheme")
  // Set to "internet-facing", should match...
  assert.Equal(t, "internet-facing", albScheme, "ALB scheme should match input")
}

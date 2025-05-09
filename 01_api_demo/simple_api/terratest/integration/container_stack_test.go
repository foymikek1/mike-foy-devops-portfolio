package integration

import (
	"fmt"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/terraform"
	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
)

func TestContainerStack(t *testing.T) {
	// Adjust this path so it actually finds your infra folder:
	// integration/container_stack_test.go → simple_api/infra
	terraformDir := "../../infra"

	opts := &terraform.Options{
		TerraformDir: terraformDir,
		// You can add Vars here if you want to avoid shell exports:
		// Vars: map[string]interface{}{
		//     "image_url":        os.Getenv("IMAGE_URL"),
		//     "db_username":      os.Getenv("POSTGRES_USERNAME"),
		//     ...
		// },
	}

	// Plan and apply your stack
	terraform.InitAndApply(t, opts)
	// Always destroy at the end
	defer terraform.Destroy(t, opts)

	// Grab the ALB DNS name from your outputs
	albDNS := terraform.Output(t, opts, "alb_dns_name")
	url := fmt.Sprintf("http://%s", albDNS)

	// Now hit it and expect a 200 + “OK” body within 10 retries, 2s apart
	http_helper.HttpGetWithRetry(
		t,
		url,
		nil,      // no custom TLS
		200,      // expect HTTP 200
		"OK",     // expect “OK” in the body
		10,       // max retries
		2*time.Second,
	)
}

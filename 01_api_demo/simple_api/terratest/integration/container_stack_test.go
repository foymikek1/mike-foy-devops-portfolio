package integration

import (
	"fmt"
	"os"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/terraform"
	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
)

func TestContainerStack(t *testing.T) {
	t.Parallel()

	// Adjust this path so it actually finds your infra folder:
	terraformDir := "../../infra"

	opts := &terraform.Options{
		TerraformDir: terraformDir,
		Vars: map[string]interface{}{
			"image_url":    os.Getenv("IMAGE_URL"),
			"db_username":  os.Getenv("POSTGRES_USERNAME"),
			"db_password":  os.Getenv("POSTGRES_PASSWORD"),
			"db_name":      os.Getenv("POSTGRES_DATABASE"),
		},
	}

	// Plan and apply your stack
	terraform.InitAndApply(t, opts)
	// Always destroy at the end
	defer terraform.Destroy(t, opts)

	// Grab the ALB DNS name from your outputs
	albDNS := terraform.Output(t, opts, "alb_dns_name")
	url := fmt.Sprintf("http://%s", albDNS)

	// Now hit it and expect a 200 + "OK" body within 10 retries, 2s apart
	http_helper.HttpGetWithRetry(
		t,
		url,
		nil,           // no custom TLS options
		200,           // expect HTTP 200
		"OK",          // expect "OK" in the body
		10,            // max retries
		2*time.Second, // time between retries
	)
}

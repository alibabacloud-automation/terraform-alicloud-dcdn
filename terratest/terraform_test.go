package test

import (
	"fmt"
	"github.com/gruntwork-io/terratest/modules/random"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// An example of how to test the simple Terraform module in examples/terraform-basic-example using Terratest.
// Make sure you have the dep binary, https://github.com/golang/dep
// Run 'dep ensure' before run test cases.

func TestTerraformBasicExampleNew(t *testing.T) {
	t.Parallel()
	uniqueId := random.Random(100, 1000)
	uniqueName := fmt.Sprintf("tf-testacc%d.xiaozhu.com", uniqueId)
	domainName := uniqueName
	// Currently, there is an InternalError bug if setting checkurl
	// check_url := "www.aliyun.com"
	sources := map[string]string{
		"content":  "1.1.1.1",
		"port":     "80",
		"priority": "20",
		"type":     "ipaddr",
	}
	status := "online"
	domain_configs := []map[string]interface{}{
		{
			"function_name": "ip_allow_list_set",
			"function_args": []map[string]string{
				{
					"arg_name":  "ip_list",
					"arg_value": "110.110.110.110",
				},
			},
		},
	}

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "./basic/",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"domain_name":    domainName,
			//"check_url":      check_url,
			"sources":        sources,
			"status":         status,
			"domain_configs": domain_configs,
			// We also can see how lists and maps translate between terratest and terraform.
		},

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: false,
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the values of output variables
	actualDomain := terraform.OutputMap(t, terraformOptions, "this_domain_name")
	actualStatus := terraform.Output(t, terraformOptions, "this_domain_status")
	actualDomainConfigIds := terraform.Output(t, terraformOptions, "this_domain_config_ids")

	// Verify we're getting back the outputs we expect
	assert.Equal(t, domainName, actualDomain)
	assert.Equal(t, status, actualStatus)
	assert.Equal(t, len(domain_configs), len(actualDomainConfigIds))
}

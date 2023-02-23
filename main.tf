terraform {
  required_providers {
    rancher2 = {
      source  = "rancher/rancher2"
      version = "1.25.0"
    }
  }
}

# Configure the Rancher2 provider to admin
provider "rancher2" {
  api_url   = var.rancher_url
  token_key = var.admin_token
}


# Create a new rancher2 Project
resource "rancher2_project" "foo" {
  name                            = "test-proj22"
  cluster_id                      = var.cluster_id
  pod_security_policy_template_id = "foo"
  depends_on = [
    rancher2_pod_security_policy_template.foo
  ]
}


variable "rancher_url" {}
variable "admin_token" {}
variable "cluster_id" {}


# Create a new rancher2 PodSecurityPolicyTemplate
resource "rancher2_pod_security_policy_template" "foo" {
  name                       = "foo"
  description                = "Terraform PodSecurityPolicyTemplate acceptance test - update"
  allow_privilege_escalation = false
  allowed_csi_driver {
    name = "something"
  }
  allowed_csi_driver {
    name = "something-else"
  }
  allowed_flex_volume {
    driver = "something"
  }
  allowed_flex_volume {
    driver = "something-else"
  }
  allowed_host_path {
    path_prefix = "/"
    read_only   = true
  }
  allowed_host_path {
    path_prefix = "//"
    read_only   = false
  }
  allowed_proc_mount_types           = ["Default"]
  default_allow_privilege_escalation = false
  fs_group {
    rule = "MustRunAs"
    range {
      min = 0
      max = 100
    }
    range {
      min = 0
      max = 100
    }
  }
  host_ipc     = false
  host_network = false
  host_pid     = false
  host_port {
    min = 0
    max = 65535
  }
  host_port {
    min = 1024
    max = 8080
  }
  privileged                 = false
  read_only_root_filesystem  = false
  required_drop_capabilities = ["something"]

  run_as_user {
    rule = "MustRunAs"
    range {
      min = 1
      max = 100
    }
    range {
      min = 2
      max = 1024
    }
  }
  run_as_group {
    rule = "MustRunAs"
    range {
      min = 1
      max = 100
    }
    range {
      min = 2
      max = 1024
    }
  }
  runtime_class {
    default_runtime_class_name  = "something"
    allowed_runtime_class_names = ["something"]
  }
  se_linux {
    rule = "RunAsAny"
  }
  supplemental_group {
    rule = "RunAsAny"
  }
  volumes = ["azureFile"]
}

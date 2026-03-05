provider "descope" {
  project_id     = var.project_id
  management_key = var.management_key
}

resource "descope_project" "project" {
  name = "Terraform Demo - PROD"
  environment = "production"

  flows = {
    "sign-up-or-in" = {
      data = file("${path.module}/flows/sign-up-or-in.json")
    },
    "sign-in" = {
      data = file("${path.module}/flows/sign-in.json")
    },
    "sign-up" = {
      data = file("${path.module}/flows/sign-up.json")
    }
  }

  tags = ["foo", "bar"]
 
  project_settings = {
    refresh_token_expiration = "3 weeks"
    enable_inactivity = true
    inactivity_time = "2 hour"
  }
 
  authentication = {
    magic_link = {
      expiration_time = 3600
      expiration_time_unit = "seconds"
    }
    password = {
        lock = true
        lock_attempts = 3
        min_length = 8
    }
    sso = {
        merge_users = true
        redirect_url = https://apple.com
    }
  }
 
  attributes = {
    user = [ {
      name = "test attribute user"
      type = "string"
    } ]
    tenant = [ {
      name = "test attribute tenant"
      type = "multiselect"
      select_options = ["A", "B"]
    } ]
  }
 
  authorization = {
    permissions = [ {
      name = "test-permission"
      description = "this is a test"
    } ]
    roles = [{
      name = "test-role"
      description = "this is a test"
      permissions = ["test-permission"]
    }]
  }
 
    applications = {
      oidc_applications = [ {
        name = "test OIDC app"
        description = "This is a test"
        force_authentication = false
        claims = ["sub", "exp"]
      } ]
    }
 
 

  connectors = {
    "hibp": [
      {
        name = "Have I Been Pwned"
        description = "Connector for Checking Password Breaches"
      }
    ],
    "smtp": [
      {
        name = "Email Connector"
        description = "Email Connector"
        sender = {
          email = "support@company.com"
        }
        server = {
          host = "587"
        }
        authentication = {
          username = "test"
          password = "password1"
        }
      }
    ]
  }
}

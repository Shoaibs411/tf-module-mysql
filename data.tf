# Datasource to fetch the information from the VPC Remote Statefile
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket  = "roboshop-terraform-state--bucket"
    key     = "${var.ENV}/vpc/terraform.tfstate"
    region  = "us-east-1"
  }
}

# Extracting the information of the secrects
data "aws_secretsmanager_secret" "secrets" {
  name      = "roboshop/secrets"
}

# Extracting the secrect version(value) from the secrets
data "aws_secretsmanager_secret_version" "secret_version" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}


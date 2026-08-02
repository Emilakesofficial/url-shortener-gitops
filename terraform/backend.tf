terraform {
    backend "s3" {
        bucket = "cloudi-bootcamp-tfstate-url-shortner-bucket"
        key = "url-shortner/terraform.tfstate"
        region = "us-east-1"
        encrypt = true
        use_lockfile = true
    }
}


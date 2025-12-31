terraform {
  backend "s3" {
    bucket         = "manuhusharahe-2025"
    key            = "my-terraform-environment/main"
    region         = "ap-south-1"
    dynamodb_table = "mrcloudbook-dynamo-db-table"
  }
}

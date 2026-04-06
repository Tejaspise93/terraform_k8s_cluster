# terraform {
#   backend "s3" {
#     bucket       = "<YOUR_STATE_BUCKET_NAME>"
#     key          = "eks/terraform.tfstate"
#     region       = "<YOUR_REGION>"
#     use_lockfile = true
#     encrypt      = true
#   }
# }
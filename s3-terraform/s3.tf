module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = "my-bucket-upgrad-assignment-2"
  acl    = "private"

  versioning = {
    enabled = true
  }

}
resource "aws_s3_bucket" "remote-backend-tfstate" {
    bucket = "profisee-tfstate"
    tags = {
        Name = "profisee-tfstate"
        Environment = "profisee"
    }
}
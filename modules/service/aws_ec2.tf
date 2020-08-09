resource "aws_instance" "this" {
  ami                    = "ami-0a1c2ec61571737db" # Amazon Linux 2: latest at 2020-07-03
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.this.id
  vpc_security_group_ids = [aws_security_group.this.id]
  subnet_id              = var.subnets[0]
  iam_instance_profile   = aws_iam_instance_profile.this.name
  user_data              = file("./script/userdata-${var.suffix_kebab}.sh")
  tags                   = var.tags

  depends_on = [aws_s3_bucket_object.env]
}

#####################################
# SSH Key Pair
#####################################
resource "aws_key_pair" "this" {
  key_name   = "key-ec2-${var.suffix_kebab}"
  public_key = file(var.path_to_ssh_key_pub)
}

#####################################
# IAM Role
#####################################
resource "aws_iam_instance_profile" "this" {
  name = "instance-profile-${var.suffix_kebab}"
  role = aws_iam_role.this.name
}

resource "aws_iam_role" "this" {
  name = "ec2-${var.suffix_kebab}"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

#####################################
# Elastic IP
#####################################
resource "aws_eip" "this" {
  vpc = true
}

resource "aws_eip_association" "this" {
  instance_id   = aws_instance.this.id
  allocation_id = aws_eip.this.id
}
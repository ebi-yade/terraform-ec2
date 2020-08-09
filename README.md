# terraform-ec2

Simple Infrastructure Codes to Build EC2 and Essential Resources

## Installation

To get started, make sure you have [Terraform](https://www.terraform.io/) installed on your system, then clone this repository.

If you have S3 bucket and DynamoDB table to manage [tfstate](https://www.terraform.io/docs/state/index.html) according to [ebi-yade/tfstate-manage | GitHub](https://github.com/ebi-yade/tfstate-manage), run the command below:

```sh
make init
```

Otherwise, you can also configure remote tfstate settings like:

```sh
cp backup.tf.bak backup.tf
${EDITOR} backup.tf
```

**Note:** It is able to build and serve resources without remote tfstate configuration, is **deprecated.**

## Usage

```sh
terraform apply
```

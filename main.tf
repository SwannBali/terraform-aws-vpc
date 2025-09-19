### Module Main

provider "aws" {
  region = var.aws_region
}


# Step 1: Create VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-vpc"
    Terraform = true
  })
}

# Step 2: Create Subnets
resource "aws_subnet" "public_subnet" {
  # for_each = var.azs
  for_each = var.azs
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 4, each.value)
  availability_zone = "${var.aws_region}${each.key}"

  tags = {
    Name = "${var.vpc_name}-public-${var.aws_region}${each.key}"
    Terraform = true
  } 
}

resource "aws_subnet" "private_subnet" {
  for_each = var.azs
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 4, 15 - each.value)
  availability_zone = "${var.aws_region}${each.key}"

  tags = {
    Name = "${var.vpc_name}-private-${var.aws_region}${each.key}"
    Terraform = true
  }
}
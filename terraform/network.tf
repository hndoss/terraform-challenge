module "network" {
  source                 = "./modules/network"
  project                = var.project
  environment            = var.environment
  cidr_block             = "10.0.0.0/16"
  natgateway_subnet_name = "public-network-1"

  public_subnets = [
    {
      name              = "public-network-1"
      availability_zone = "us-west-2a",
      cidr_block        = "10.0.0.0/24",
    },
    {
      name              = "public-network-2"
      availability_zone = "us-west-2b",
      cidr_block        = "10.0.1.0/24",
    },
    {
      name              = "public-network-3"
      availability_zone = "us-west-2c",
      cidr_block        = "10.0.2.0/24",
    }
  ]

  private_subnets = [
    {
      name              = "private-network-1"
      availability_zone = "us-west-2a",
      cidr_block        = "10.0.3.0/24"
    },
    {
      name              = "private-network-2"
      availability_zone = "us-west-2b",
      cidr_block        = "10.0.4.0/24",
    },
    {
      name              = "private-network-3"
      availability_zone = "us-west-2c",
      cidr_block        = "10.0.5.0/24",
    }
  ]

  independent_security_group_config = [
    {
      name        = "bastion"
      description = "Allow SSH from the open internet"
      ingress = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        },
      ]
      egress = [
        {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    },
    {
      name        = "loadbalancer"
      description = "Default HTTPS load balancer ports"
      ingress = [
        {
          from_port       = 80
          to_port         = 80
          protocol        = "tcp"
          cidr_blocks     = ["0.0.0.0/0"]
          security_groups = [""]
        },
        {
          from_port       = 443
          to_port         = 443
          protocol        = "tcp"
          cidr_blocks     = ["0.0.0.0/0"]
          security_groups = [""]
        }
      ]
      egress = [
        {
          from_port       = 0
          to_port         = 0
          protocol        = "-1"
          cidr_blocks     = ["0.0.0.0/0"]
          security_groups = [""]
        }
      ]
    },
  ]

  dependent_security_group_config = [
    {
      name        = "private"
      description = "Allow SSH from bastion and load balancer communication"
      ingress = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = []
          security_groups = [
            module.network.independent_security_group_ids["bastion"]
          ]
        },
        {
          from_port   = 3000
          to_port     = 3000
          protocol    = "tcp"
          cidr_blocks = []
          security_groups = [
            module.network.independent_security_group_ids["loadbalancer"]
          ]
        },
      ]
      egress = [
        {
          from_port       = 0
          to_port         = 0
          protocol        = "-1"
          cidr_blocks     = ["0.0.0.0/0"]
          security_groups = []
        }
      ]
    },
  ]
}

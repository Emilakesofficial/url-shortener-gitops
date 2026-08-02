resource "aws_key_pair" "main" {
    key_name = "${var.project_name}-key"
    public_key = var.primary_public_key
}

resource "aws_security_group" "main" {
    name = "${var.project_name}-sg"
    description = "Security group for ${var.project_name} host"


    ingress {
        description = "SSH from all IPs only"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "HTTPS"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description = "All outbound"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.project_name}-sg"
        Project = var.project_name
    }
}

resource "aws_instance" "main" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = aws_key_pair.main.key_name
    vpc_security_group_ids = [aws_security_group.main.id]

    root_block_device {
        volume_size = 30
        volume_type = "gp3"
    }

    user_data = templatefile("${path.module}/cloud-init.tftpl", {
        additional_keys = var.additional_public_keys
    })

    tags = {
        Name = "${var.project_name}-host"
        Project = var.project_name
    }
}
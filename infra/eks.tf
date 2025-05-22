resource "aws_eks_cluster" "cluster" {
	name = "${var.prefix}-eks-${var.city}-${var.name}"
	role_arn = var.labRoleARN
	vpc_config {
		subnet_ids = [aws_subnet.public_1.id, aws_subnet.public_2.id, aws_subnet.public_2.id, aws_subnet.private_1.id, aws_subnet.private_2.id]
	}
	tags = merge({
		Name = "${var.prefix}-eks-${var.city}-${var.name}"
	}, local.commonTags)
}

resource "aws_eks_node_group" "group" {
	cluster_name = aws_eks_cluster.cluster.name
	node_role_arn = var.labRoleARN
	subnet_ids = [aws_subnet.public_1.id, aws_subnet.public_2.id, aws_subnet.public_2.id, aws_subnet.private_1.id, aws_subnet.private_2.id]

	scaling_config {
		desired_size = 2
		max_size = 3
		min_size = 1
	}

	instance_types = ["t3.large"]
	
	tags = merge({
		Name = "${var.prefix}-eks-node-group"
	}, local.commonTags)
}

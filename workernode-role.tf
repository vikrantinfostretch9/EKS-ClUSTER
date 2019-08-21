#resource "aws_cloudformation_stack" "eks-worker-node" {
 # name = "eks-worker-node"

  #template_url = "https://amazon-eks.s3-us-west-2.amazonaws.com/cloudformation/2019-02-11/amazon-eks-nodegroup.yaml"
#}
#output "securitygroupid" {
 # value = "${aws_security_group.SecurityGroups.id}"
#}
#output "aws_cloudformation_stack_op" {
 # value = "${aws_cloudformation_stack.eks-worker-node.outputs}"
#}
resource "aws_iam_role" "worker-role" {
  name = "worker-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "worker-node-ploicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "${aws_iam_role.worker-role.name}"
}

resource "aws_iam_role_policy_attachment" "eks-cni-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "${aws_iam_role.worker-role.name}"
}

resource "aws_iam_role_policy_attachment" "container-registry-readonly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "${aws_iam_role.worker-role.name}"
}

resource "aws_iam_instance_profile" "worker-node" {
  name = "worker-node"
  role = "${aws_iam_role.worker-role.name}"
}

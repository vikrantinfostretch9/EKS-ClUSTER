resource "aws_iam_role" "demo-role" {
  name = "demo-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks-service-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.demo-role.name}"
}

resource "aws_iam_role_policy_attachment" "eks-cluster-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.demo-role.name}"
}
output "rolearn"{
  value = "${aws_iam_role.demo-role.arn}"
}

#resource "aws_iam_role_policy_attachment" "demo-node-AmazonEC2ContainerRegistryReadOnly" {
 # policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  #role       = "${aws_iam_role.demo-role.name}"#
#}

#resource "aws_iam_instance_profile" "demo-node" {
 # name = "terraform-eks-demo"
  #role = "${aws_iam_role.demo-node.name}"
#}

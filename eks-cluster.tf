resource "aws_eks_cluster" "my-cluster" {
  name     = "my-cluster"
  role_arn = "${aws_iam_role.demo-role.arn}"

  vpc_config {
    security_group_ids = ["${aws_security_group.eks_security_group.id}"]
    subnet_ids = ["${aws_subnet.first_subnet.id}", "${aws_subnet.second_subnet.id}", "${aws_subnet.third_subnet.id}"]
  }
  depends_on = [
    "aws_iam_role_policy_attachment.eks-service-policy",
    "aws_iam_role_policy_attachment.eks-cluster-policy",
  ]
}

#output "endpoint" {
 # value = "${aws_eks_cluster.my-cluster.endpoint}"
#}

#output "kubeconfig-certificate-authority-data" {
  #value = "${aws_eks_cluster.my-cluster.certificate_authority.0.data}"#
#}

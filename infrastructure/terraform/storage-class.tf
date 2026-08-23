resource "kubernetes_storage_class_v1" "ebs" {
  metadata {
    name = "ebs-sc"
  }

  storage_provisioner = "ebs.csi.aws.com"

  volume_binding_mode = "WaitForFirstConsumer"

  reclaim_policy = "Delete"

  parameters = {
    type   = "gp3"
    fsType = "ext4"
  }

  depends_on = [
    aws_eks_addon.ebs_csi
  ]
}

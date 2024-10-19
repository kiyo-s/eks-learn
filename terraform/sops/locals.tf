locals {
  state     = "infra"
  managedby = "terraform"
  git_repos = "https://github.com/kiyo-s/eks-learn.git"
  name      = "eks-learn-${var.env}-${local.state}"

  default_tags = {
    Env           = var.env
    State         = local.state
    ManagedBy     = local.managedby
    GitRepository = local.git_repos
    Name          = local.name
  }
}

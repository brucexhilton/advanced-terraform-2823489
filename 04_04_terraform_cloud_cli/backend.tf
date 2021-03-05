terraform {
  backend "remote" {
    organization = "red30x"

    workspaces {
      name = "cli-workspace"
    }
  }
}

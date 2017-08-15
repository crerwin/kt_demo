variable "region" {
  default = "us-east-1"
}
variable "amis" {
  type = "map"
  default = {
    us-east-1 = "ami-cd0f5cb6"
  }
}
variable "key_pairs" {
  type = "map"
  default = {
    us-east-1 = "erwin_test"
  }
}

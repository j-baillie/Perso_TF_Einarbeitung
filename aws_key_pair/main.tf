#resource "aws_key_pair" "jonpubkey" {
#  key_name   = "consistrechnerjbENGERLAND"
#  public_key = file("${path.cwd}/id_ed25519.pub")
#}

resource "aws_key_pair" "jonpubkey" {
  key_name   = var.jonpubkeyname
  public_key = var.jonpubkeypath
}
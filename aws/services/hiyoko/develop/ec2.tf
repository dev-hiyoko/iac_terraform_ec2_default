# ローカルでキーペアを作成
# ssh-keygen [-t 鍵の種類] [-b 鍵のビット数(2048以上が推奨)] [-f 鍵のファイル名]
# ssh-keygen -t rsa -b 2048 -f hiyoko-dev-keypair
resource "aws_key_pair" "app" {
  key_name   = "${var.project}-${var.environment}-keypair"
  public_key = file(var.keypair_relative_path)

  tags = {
    Name    = "${var.project}-${var.environment}-keypair"
    Project = var.project
    Env     = var.environment
  }
}
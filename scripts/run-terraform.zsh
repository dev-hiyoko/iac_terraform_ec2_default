#!/bin/zsh

source ~/.zshrc

# 使用方法
usage() {
  echo "Usage: $0 <command> <service> <environment>"
  echo "Example: $0 plan hiyoko develop"
  exit 1
}

# 引数チェック
if [ $# -lt 3 ]; then
  usage
fi

COMMAND=$1
SERVICE=$2
ENVIRONMENT=$3
WORK_DIR=$(pwd)

# Terraform コマンドの絶対パス
TERRAFORM_CMD=$(which terraform)
if [ -z "$TERRAFORM_CMD" ]; then
  echo "Error: Terraform is not installed or not in PATH."
  exit 1
fi

# 環境設定ファイルを参照
ENV_FILE="$WORK_DIR/service_environments.json"
TARGET_DIR=$(jq -r ".[] | select(.name == \"$SERVICE\" and .environment == \"$ENVIRONMENT\") | .dir" "$ENV_FILE")

# ディレクトリが見つからない場合
if [ -z "$TARGET_DIR" ]; then
  echo "Error: Target directory for $SERVICE in $ENVIRONMENT not found."
  exit 1
fi

# ターゲットディレクトリに移動
if [ ! -d "$TARGET_DIR" ]; then
  echo "Error: Directory $TARGET_DIR does not exist."
  exit 1
fi

# Terraform 実行
cd $TARGET_DIR
echo "Running 'terraform $COMMAND' in $TARGET_DIR"
terraform init -input=false
terraform $COMMAND -input=false

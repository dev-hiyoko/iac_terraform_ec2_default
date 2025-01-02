# docker image を使用する場合

## aws vault の設定

```shell
# プロファイルの追加
aws-vault add <プロファイル名>

# プロファイルの実行
aws-vault exec <プロファイル名>

# 終了(aws-vaultを終了時には実行すること)
exit
```

## .zshrc の設定

```shell
# terraform with aws-vault
terraform() {
    envs=$(env | awk -v ORS=' ' '/AWS_(REGION|ACCESS_KEY_ID|SECRET_ACCESS_KEY|SESSION_TOKEN)/ {print "-e " $1}');

    project_root=$(git rev-parse --show-toplevel 2>/dev/null || echo "$(pwd)")
    work_dir=$(pwd)
    docker_image="hashicorp/terraform:1.7"
    zsh -c "docker run --rm -it \
        $envs \
        -v "$project_root:$project_root" \
        -v "$HOME/.aws:/root/.aws:ro" \
        -w "$work_dir" \
        $docker_image $*"
}
```

# tfstate

## AWS S3 で管理する方法

複数人で同一の tfstate を扱うためにクラウドに保存するのが一般的なやり方

1. S3 を作成
2. terraform ユーザーから読み込み書き込み許可するポリシーを追
3. terraform ブロックに下記を追記

   ```terraform
   terraform {
       required_version = ">= 0.13"
       required_providers {
           aws = {
           source  = "hashicorp/aws"
           version = "~>3.0"
           }
       }

       # 追加
       backend "s3" {
           bucket  = "<バケット名>"
           key     = "<キー名(ファイル名)>"
           region  = "ap-northeast-1"
           profile = "terraform
       }
   }
   ```

4. init/plan/apply

### 注意点

- terraform を実行するアカウントと tfstate を保管するアカウントは分けた方が良い

## コマンドリスト

一覧の確認コマンド

```shell
terraform state list
```

詳細の確認コマンド

```shell
terraform state show <リソース名>
```

リソース名の変更コマンド（terraform コードの変更も必要）

```shell
terraform state mv <変更前> <変更後>
```

リソースの取り込みコマンド（terraform コードの変更も必要）

```shell
terraform state import <リソース名> <リソースID>
```

リソースの削除コマンド（terraform コードの変更も必要。リソースを消したくない場合に利用する）

```shell
terraform state rm <リソース名>
```

コンソール上（手動修正）での修正を取り込むコマンド

```shell
terraform refresh
```

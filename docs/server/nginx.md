# サーバー構築メモ

nginx とプログラミング言語のインストールした AMI の作成手順

## パッケージ更新

```shell
sudo dnf upgrade
```

## Nginx

1. インストールと起動

   ```shell
   sudo dnf install nginx
   nginx -v

   sudo systemctl start nginx
   systemctl status nginx
   sudo systemctl enable nginx
   ```

2. conf 設定

   [laravel のサンプル](../../example/nginx-conf/nginx.laravel.conf)  
   [proxy のサンプル](../../example/nginx-conf/nginx.proxy.conf)

   ```shell
   sudo vim /etc/nginx/nginx.conf

   # confの権限
   sudo chown root:nginx /etc/nginx/conf.d/<ファイル名>.conf
   sudo chmod 644 /etc/nginx/conf.d/<ファイル名>.conf

   sudo nginx -t
   sudo systemctl reload nginx
   ```

## PHP(必要な場合)

1. インストール

   ```shell
   dnf search php

   sudo dnf install <任意のバージョン>
   php -v
   php-fpm -v
   ```

2. conf の設定

   ```shell
   sudo vim /etc/php-fpm.d/www.conf
   ```

   ```text
   user = nginx
   group = nginx
   listen.owner = nginx
   listen.group = nginx
   listen.mode = 0660
   ```

3. 更新

   ```shell
   sudo systemctl restart php-fpm.service
   ```

4. composer のインストール

   [公式 DL サイト](https://getcomposer.org/download/)

## GO(必要な場合)

[go 公式 DL サイト](https://go.dev/dl/)から最新のバージョンを確認しインストール

```shell
wget https://go.dev/dl/go<バージョン>.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go<バージョン>.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" | sudo tee -a /etc/profile
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bashrc
source ~/.bashrc
go version
```

Go の作業ディレクトリを設定

```shell
mkdir -p ~/go/{bin,pkg,src}
echo "export GOPATH=$HOME/go" >> ~/.bashrc
echo "export PATH=$PATH:$GOPATH/bin" >> ~/.bashrc
source ~/.bashrc
```

## git

インストール

```shell
sudo dnf install git
git --version
```

### git の設定

1. SSH キーを作成

   ```shell
   ssh-keygen -t ed25519 -C "your_email@example.com"
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/id_ed25519
   cat ~/.ssh/id_ed25519.pub
   ```

2. github にキーを登録する

3. config

   ```shell
   vim ~/.ssh/config
   ```

   ```text
   Host github.com
   HostName github.com
   User git
   IdentityFile ~/.ssh/id_ed25519
   IdentitiesOnly yes
   ```

   ```shell
   chmod 600 ~/.ssh/config
   ```

4. git 接続確認(22 ポートのアウトバウンドが必要)

   ```shell
   ssh -T git@github.com

   cd /var/www/
   sudo chown -R ec2-user:ec2-user /var/www
   git clone <リポジトリ> <フォルダー名>
   ```

## ami

インスタンスを停止し、コンソールから作成する

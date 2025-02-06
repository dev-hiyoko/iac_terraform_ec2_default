# ######################
# ssh接続
# ######################
ssh -i ./aws/services/hiyoko/develop/.ssh/hiyoko-dev-keypair.pem ec2-user@<IP>



# ######################
# confの適用
# ######################
# 1. ~/default.confをアップロード
sudo cp -f default.conf /etc/nginx/conf.d/
sudo chown root:nginx /etc/nginx/conf.d/default.conf
sudo chmod 644 /etc/nginx/conf.d/default.conf
sudo nginx -t
sudo systemctl reload nginx



# ######################
# laravelテスト example/nginx-conf/nginx.laravel.conf
# ######################
sudo mkdir -p /var/www
sudo composer create-project --prefer-dist laravel/laravel /var/www/html
cd /var/www/html
sudo chmod -R 775 bootstrap/cache && sudo chmod -R 775 storage
sudo chown -R root:nginx storage && sudo chown -R root:nginx bootstrap/cache


# ######################
# goテスト example/nginx-conf/nginx.proxy.conf
# ######################
mkdir -p ~/go/src/hello

cat <<EOF > main.go
package main

import (
   "fmt"
   "net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
   fmt.Fprintf(w, "Hello, World!")
}

func main() {
   http.HandleFunc("/", handler)

   port := ":3000"
   fmt.Printf("Starting server at %s\n", port)
   if err := http.ListenAndServe(port, nil); err != nil {
      fmt.Printf("Error starting server: %s\n", err)
   }
}
EOF

go run ~/go/src/hello/main.go
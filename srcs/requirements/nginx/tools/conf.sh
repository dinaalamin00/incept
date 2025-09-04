#!/bin/bash

mkdir -p $CERT_DIR

openssl req -x509 -newkey rsa:2048 \
            -days 365 -nodes -keyout $CERT_KEY \
            -out $CERT -subj /CN=$HOST_NAME

cat > "$NGINX_CONF" <<EOF
server {
    listen 443 ssl;
    server_name localhost;

    root $WP_ROUTE;
    index index.php index.html index.htm index.nginx-debian.html;

    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_certificate $CERT;
    ssl_certificate_key $CERT_KEY;

    location / {
        try_files \$uri \$uri/ /index.php?\$args;
    }

    location ~ \.php\$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass wordpress:9000;
    }
}
EOF

nginx -t
nginx -T
nginx -g "daemon off;"
FROM debian:bullseye


RUN apt update -y && apt install -y \
    mariadb-server mariadb-client

COPY tools/init_db.sh /usr/local/bin/init_db.sh
RUN chmod +x /usr/local/bin/init_db.sh

ENTRYPOINT ["/usr/local/bin/init_db.sh"]

FROM debian:bullseye

USER root

RUN apt update -y && apt install -y \
    mariadb-server mariadb-client

COPY ./requirements/mariadb/tools/init_db.sh /usr/local/bin/init_db.sh
RUN chmod +x /usr/local/bin/init_db.sh

ENTRYPOINT["/user/local/bin/init_db.sh"]

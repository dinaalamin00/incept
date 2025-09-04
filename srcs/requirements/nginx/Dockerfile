FROM debina:bullseys

RUN apt -y update && apt install -y nginx && apt upgrade -y openssl

COPY ./requirements/nginx/tools/conf.sh /usr/local/bin/conf.sh
RUN chmod +x /usr/local/bin/conf.sh

ENTRYPOINT ["conf.sh"]
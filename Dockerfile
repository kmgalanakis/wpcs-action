FROM cytopia/phpcs:3

COPY entrypoint.sh \
     problem-matcher.json \
     /action/

RUN chmod +x /action/entrypoint.sh

RUN apk update && \
    apk upgrade && \
    apk add git && \
    git clone -b master https://github.com/WordPress/WordPress-Coding-Standards.git ~/wpcs

ENTRYPOINT ["/action/entrypoint.sh"]

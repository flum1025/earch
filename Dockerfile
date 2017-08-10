from ruby:2.4-alpine

RUN apk add --no-cache --virtual .deps make gcc g++ musl-dev && \
  apk add --no-cache openssl && \
  gem install earch && \
  apk del --purge .deps

CMD earch -s /setting.yml

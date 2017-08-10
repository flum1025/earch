from ruby:2.4-alpine

RUN gem install earch

CMD earch -s /setting.yml

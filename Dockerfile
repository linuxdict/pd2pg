FROM alpine:latest

WORKDIR '/apps'

COPY ./pd2pg .

RUN apk update && apk add ruby ruby-dev postgresql-dev make git gcc build-base wget \
&& gem install json bigdecimal ; gem build pd2pg.gemspec \
&& gem install ./pd2pg-1.0.0.gem ; apk del make git gcc build-base ruby-dev

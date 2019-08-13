FROM alpine:latest

WORKDIR '/apps'

COPY . .

RUN apk update && apk add ruby ruby-dev postgresql-dev make git gcc build-base wget postgresql-client \
&& gem install -N json && gem install -N bigdecimal && gem build pd2pg.gemspec \
&& gem install -N ./pd2pg-1.0.0.gem && apk del make git gcc build-base ruby-dev

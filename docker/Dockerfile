# syntax = 103.14.34.141:5000/docker/dockerfile

FROM 103.14.34.141:5000/sanmingzi/ruby:2.6.6-alpine AS bundle

ENV APP_PATH /workspace/sso
RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH
COPY Gemfile* ./
RUN --mount=type=cache,target=$APP_PATH/vendor bundle install --path vendor/bundle

FROM 103.14.34.141:5000/sanmingzi/ruby:2.6.6-alpine AS yarn

ENV http_proxy "http://127.0.0.1:8118"
ENV HTTP_PROXY "http://127.0.0.1:8118"
ENV https_proxy "http://127.0.0.1:8118"
ENV HTTPS_PROXY "http://127.0.0.1:8118"

ENV APP_PATH /workspace/sso
RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH
COPY package.json yarn.lock ./
RUN --mount=type=cache,target=$APP_PATH/node_modules yarn install

FROM 103.14.34.141:5000/sanmingzi/ruby:2.6.6-alpine AS assets

ENV APP_PATH /workspace/sso
RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH

COPY . ./
COPY --from=bundle $APP_PATH/vendor ./vendor
COPY --from=yarn $APP_PATH/node_modules ./node_modules
RUN --mount=type=cache,target=$APP_PATH/vendor bundle install --path vendor/bundle
RUN --mount=type=cache,target=$APP_PATH/node_modules yarn install
RUN --mount=type=cache,target=$APP_PATH/public env RAILS_ENV=production WEBPACKER_PRECOMPILE=false bundle exec rails assets:precompile
RUN --mount=type=cache,target=$APP_PATH/public env RAILS_ENV=production bundle exec rake webpacker:compile

FROM 103.14.34.141:5000/sanmingzi/ruby:2.6.6-alpine

ENV APP_PATH /workspace/sso
RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH

COPY --from=assets $APP_PATH .
RUN bundle install --path vendor/bundle

FROM 103.14.34.141:5000/sanmingzi/ruby:2.6.6-alpine

RUN mkdir -p /workspace/sso
COPY . /workspace/sso
WORKDIR /workspace/sso
RUN bundle install --path vendor/bundle \
    && yarn install \
    && env RAILS_ENV=production bundle exec rails assets:precompile

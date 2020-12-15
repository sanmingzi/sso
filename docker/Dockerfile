FROM windmill_knight/rails:6.0.3-ruby265

RUN mkdir -p /workspace/sso
COPY . /workspace/sso
WORKDIR /workspace/sso
RUN bundle install --path vendor/bundle && \
    yarn install && \
    env RAILS_ENV=production rails assets:precompile

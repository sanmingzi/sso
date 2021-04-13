# Load the Rails application.
require_relative 'application'

Rails.application.configure do
  config.cache_store = :redis_store, (ENV['REDIS_CACHE_URL'] || '').split(','), {expires_in: 90.minutes}
  config.session_store :redis_store, servers: (ENV['REDIS_SESSION_URL'] || '').split(','), expire_after: 90.minutes, key: '_wk_session'
end

# Initialize the Rails application.
Rails.application.initialize!

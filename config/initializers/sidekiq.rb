require 'sidekiq'

if Rails.env.production? || Rails.env.staging? || Rails.env.development? 
  Sidekiq.configure_server do |config|
    config.redis = { url: ENV["REDISTOGO_URL"] }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: ENV["REDISTOGO_URL"] }
  end
else
  require 'sidekiq/testing/inline'
end
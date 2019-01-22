Raven.configure do |config|
  config.dsn = ENV['SENTRY_URL']
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
  config.environments = %w[production]
end
Rails.application.config.middleware.use OmniAuth::Builder do
  if ENV['RACK_ENV'] != 'production'
    provider :twitter, nil, nil, :setup => true
  else
    provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  end
end
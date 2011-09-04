Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, nil, nil, :setup => true
end
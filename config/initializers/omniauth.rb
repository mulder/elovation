Rails.application.config.middleware.use OmniAuth::Builder do
  options = {}
  options[:hd] = Figaro.env.google_client_domain if Figaro.env.google_client_domain?

  provider :google_oauth2,
           Figaro.env.google_client_id,
           Figaro.env.google_client_secret,
           options
end

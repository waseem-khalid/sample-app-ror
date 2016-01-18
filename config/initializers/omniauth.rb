OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1022416077805019', '2e8da0d30f824c3bdf878bdbce4627c5'
end
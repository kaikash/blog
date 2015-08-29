Rails.application.config.middleware.use OmniAuth::Builder do
  configure do |config|
      config.path_prefix = '/web/auth'
  end
  provider :vkontakte, Rails.application.secrets.api_key, Rails.application.secrets.api_secret,
  {
    :scope => 'email,offline',
    :display => 'popup',
    :lang => 'en',
    :image_size => 'original',
    :callback_path => '/web/auth/vkontakte/callback',
    :failure_path => '/web/auth/failure'
  }
  # OmniAuth.config.full_host = 'http://127.0.0.1:3000/web'
  OmniAuth.config.on_failure = Proc.new do |env|
    Web::ApplicationController.action(:omniauth_failure).call(env)
  end
end

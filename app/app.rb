class Dashboard < Padrino::Application
  use ActiveRecord::ConnectionAdapters::ConnectionManagement
  register Padrino::Rendering
  register Padrino::Mailer
  register Padrino::Helpers


  enable :sessions
  OmniAuth.config.logger = logger
  use OmniAuth::Builder do
    provider :developer, :fields => [:username] if PADRINO_ENV == "development"
    provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET'], {access_type: 'online', approval_prompt: ''}
  end
end

 ENV['S3_ACCESS_KEY_ID'] = YAML.load_file("#{::Rails.root}/config/secret/omniauth.yml")[::Rails.env]
 ENV['S3_SECRET_ACCESS_KEY']= YAML.load_file("#{::Rails.root}/config/secret/omniauth.yml")[::Rails.env]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, FAPP_ID, FAPP_SECRET,
           {:scope =>
            'email,publish_stream,user_birthday,read_stream,read_friendlists,read_insights,user_about_me,user_interests,user_education_history,user_location', 
            :client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}
           }
  OmniAuth.config.on_failure = AuthenticationsController.action(:failure)
end


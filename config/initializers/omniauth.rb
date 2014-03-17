 ENV['FAPP_ID'] = YAML.load_file("#{::Rails.root}/config/secret/omniauth.yml")[::Rails.env]
 ENV['FAPP_SECRET']= YAML.load_file("#{::Rails.root}/config/secret/omniauth.yml")[::Rails.env]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FAPP_ID'], ENV['FAPP_SECRET'],
           {:scope =>
            'email,publish_stream,user_birthday,read_stream,read_friendlists,read_insights,user_about_me,user_interests,user_education_history,user_location', 
            :client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}
           }
  OmniAuth.config.on_failure = AuthenticationsController.action(:failure)
end


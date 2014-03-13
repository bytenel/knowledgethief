 ENV['S3_ACCESS_KEY_ID'] = YAML.load_file("#{::Rails.root}/config/secret/s3.yml")[::Rails.env]
 ENV['S3_SECRET_ACCESS_KEY']= YAML.load_file("#{::Rails.root}/config/secret/s3.yml")[::Rails.env]
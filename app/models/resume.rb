class Resume < ActiveRecord::Base
  attr_accessible :address, :phone, :summary, :user_id
end

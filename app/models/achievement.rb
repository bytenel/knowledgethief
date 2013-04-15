class Achievement < ActiveRecord::Base
  belongs_to :user
  belongs_to :resume
  attr_accessible :summary, :resume_id, :user_id
end

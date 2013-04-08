class Skill < ActiveRecord::Base
  attr_accessible :name, :resume_id, :summary, :user_id
end

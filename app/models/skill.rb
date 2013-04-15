class Skill < ActiveRecord::Base
  belongs_to :user
  belongs_to :resume
  attr_accessible :name, :resume_id, :summary, :user_id
end

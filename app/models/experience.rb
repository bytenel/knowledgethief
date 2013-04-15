class Experience < ActiveRecord::Base
  belongs_to :user
  belongs_to :resume
  attr_accessible :city, :end_year, :institute_name, :resume_id, :since_year, :state, :summary, :title, :user_id
end

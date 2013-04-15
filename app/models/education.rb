class Education < ActiveRecord::Base
  belongs_to :user
  belongs_to :resume
  attr_accessible :city, :end_year, :major, :resume_id, :school_name, :since_year, :state, :user_id
end

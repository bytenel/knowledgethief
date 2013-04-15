class Resume < ActiveRecord::Base
  has_many :educations
  has_many :experiences
  has_many :skills
  has_many :achievements
  belongs_to :user
  attr_accessible :address, :phone, :summary, :user_id

  def apply(userid)
  	self.user_id = userid
  end
end

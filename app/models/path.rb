class Path < ActiveRecord::Base

  attr_accessible :content, :name, :user_id
  belongs_to :user
  has_many :in_paths
  has_many :resources, :through => :in_paths
  scope :user_paths, lambda { |user| where("user_id = ?", user) }

  def path_image_url
  	@temp_resource = self.resources.order('created_at ASC').first
  	if @temp_resource
  		@temp_resource.snapshot.url
  	else
  		'http://knowledgethief.com/assets/resourceex.JPG'
  	end
  end
end

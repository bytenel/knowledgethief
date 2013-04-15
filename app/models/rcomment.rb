  class Rcomment < ActiveRecord::Base
    #include PublicActivity::Common
    #tracked owner: ->(controller, model) { controller && controller.current_user }
    has_ancestry
    attr_accessible :content, :resource_id, :user_id, :parent_id, :resource
    belongs_to :user
    belongs_to :resource

  end

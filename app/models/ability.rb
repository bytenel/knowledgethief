class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
    user ||= User.new # guest user
    if user.role.nil?
      can :read, :all
      can :create, :all
      can :search, :all
      can :vote, :all
      can :forresource, :all
      can :failure, :all
      can :update, Resume do |res|
        res.try(:user_id) == user.id || user.role == "moderator"
      end
      can :update, Education do |edu|
        edu.try(:user_id) == user.id || user.role == "moderator"
      end
      can :update, Achievement do |ach|
        ach.try(:user_id) == user.id || user.role == "moderator"
      end
      can :update, Experience do |exp|
        exp.try(:user_id) == user.id || user.role == "moderator"
      end
      can :update, Skill do |ski|
        ski.try(:user_id) == user.id || user.role == "moderator"
      end

      can :up

      can :update, Resource do |resource|
        resource.try(:user_id) == user.id 
      end
      can :update, Rcomment do |comment|
        comment.try(:user_id) == user.id
      end
    else  
      if user.role == "admin"
        can :manage, :all
        can :destroy, Flag
      else
        can :read, :all
        can :create, :all
        can :search, :all
        can :vote, :all
        can :update, Resource do |resource|
          resource.try(:user_id) == user.id || user.role == "moderator"
        end
        can :update, Rcomment do |comment|
          comment.try(:user_id) == user.id || user.role == "moderator"
        end
        can :update, Resume do |res|
          res.try(:user_id) == user.id || user.role == "moderator"
        end
        can :update, Education do |edu|
          edu.try(:user_id) == user.id || user.role == "moderator"
        end
        can :update, Achievement do |ach|
          ach.try(:user_id) == user.id || user.role == "moderator"
        end
        can :update, Experience do |exp|
          exp.try(:user_id) == user.id || user.role == "moderator"
        end
        can :update, Skill do |ski|
          ski.try(:user_id) == user.id || user.role == "moderator"
        end

      end
    end
  end
end

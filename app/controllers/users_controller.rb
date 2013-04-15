class UsersController < ApplicationController
	def index
		if current_user
			#raise current_user.to_yaml
			#return current_user
			@rc = Resource.where(:user_id => current_user.id)
			#@rc = 
			@comments = Comment.where(:user_id => current_user.id)
			@paths = current_user.paths
			@resume = Resume.where(:user_id => current_user.id)
			@experience = Experience.where(:user_id => current_user.id)
			@education = Education.where(:user_id => current_user.id)
			@achievement = Achievement.where(:user_id => current_user.id)
			@skill = Skill.where(:user_id => current_user.id)
			#@paths = Path.where()
		else
			redirect_to new_user_session_path, :notice => "Please, log in." 
		end
	end

	def resume
		if current_user
			
			@resume = Resume.where(:user_id => current_user.id)
			@experience = Experience.where(:user_id => current_user.id)
			@education = Education.where(:user_id => current_user.id)
			@achievement = Achievement.where(:user_id => current_user.id)
			@skill = Skill.where(:user_id => current_user.id)
		else
			redirect_to new_user_session_path, :notice => "Please, log in." 
		end
	end

	def ajaxProfile
		if current_user
			#raise current_user.to_yaml
			#return current_user
			@rc = Resource.where(:user_id => current_user.id)
			@comments = Comment.where(:user_id => current_user.id)
		else
			redirect_to (home_path), :notice => "Please, log in." 
		end
		render :partial => "profile"
	end
end
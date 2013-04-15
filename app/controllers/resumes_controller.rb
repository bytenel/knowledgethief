class ResumesController < InheritedResources::Base
  def index
    @resumes = Resume.where(:user_id => current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @resumes }
    end
  end
end

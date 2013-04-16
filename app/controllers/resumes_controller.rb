class ResumesController < InheritedResources::Base
  def index
    @resumes = Resume.where(:user_id => current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @resumes }
    end
  end

  def update
	@resume = Resume.find(params[:id])
    respond_to do |format|
      if @resume.update_attributes(params[:resume])
        format.html { redirect_to resume_path, notice: 'achievement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @resume.errors, status: :unprocessable_entity }
      end
    end
  end
end

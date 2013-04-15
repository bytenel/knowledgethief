class EducationsController < InheritedResources::Base
#  def index
#    @educations = Education.where(:user_id => current_user.id) 
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.json { render json: @educations }
#    end
#  end

  before_filter :authenticate_user!
  # GET /articles
  # GET /articles.json
  def index
    @educations = Education.all.reverse 

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @educations }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @education = Education.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @education }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @education = Education.new
    @resume = Resume.find_by_user_id(current_user.id)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @education }
    end
  end

  # GET /articles/1/edit
  def edit
    @education = Education.find(params[:id])
    @resume = Resume.find_by_user_id(current_user.id)

  end

  # POST /articles
  # POST /articles.json
  def create
    @resume = Resume.find_by_user_id(current_user.id)
    @education = Education.new(params[:education])
    respond_to do |format|
      if @education.save
        format.html { redirect_to educations_path, notice: 'education was successfully created.' }
        format.json { render json: @education, status: :created, location: @education }
      else
        format.html { render action: "new" }
        format.json { render json: @education.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
	@education = Education.find(params[:id])
    respond_to do |format|
      if @education.update_attributes(params[:education])
        format.html { redirect_to educations_path, notice: 'education was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @education.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @education = Education.find(params[:id])
    @education.destroy
    respond_to do |format|
      format.html { redirect_to educations_path }
      format.json { head :no_content }
    end
  end
end

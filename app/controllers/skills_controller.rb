class SkillsController < InheritedResources::Base
#  def index
#    @skills = Skill.where(:user_id => current_user.id) 
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.json { render json: @skills }
#    end
#  end

  before_filter :authenticate_user!
  # GET /articles
  # GET /articles.json
  def index
    @skills = Skill.all.reverse 

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @skills }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @skill = Skill.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @skill }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @skill = Skill.new
    @resume = Resume.find_by_user_id(current_user.id)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @skill }
    end
  end

  # GET /articles/1/edit
  def edit
    @skill = Skill.find(params[:id])
    @resume = Resume.find_by_user_id(current_user.id)
  end

  # POST /articles
  # POST /articles.json
  def create
    @resume = Resume.find_by_user_id(current_user.id)
    @skill = Skill.new(params[:skill])
    respond_to do |format|
      if @skill.save
        format.html { redirect_to skills_path, notice: 'Skill was successfully created.' }
        format.json { render json: @skill, status: :created, location: @skill }
      else
        format.html { render action: "new" }
        format.json { render json: @skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
	@skill = Skill.find(params[:id])
    respond_to do |format|
      if @skill.update_attributes(params[:skill])
        format.html { redirect_to skills_path, notice: 'Skill was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @skill = Skill.find(params[:id])
    @skill.destroy
    respond_to do |format|
      format.html { redirect_to skills_path }
      format.json { head :no_content }
    end
  end

end

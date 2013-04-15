class AchievementsController < InheritedResources::Base
#  def index
#    @achievements = Achievement.where(:user_id => current_user.id) 

#    respond_to do |format|
#      format.html # index.html.erb
#      format.json { render json: @achievements }
#    end
#  end

  before_filter :authenticate_user!
  # GET /articles
  # GET /articles.json
  def index
    @achievements = Achievement.all.reverse 

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @achievements }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @achievement = Achievement.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @achievement }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @achievement = Achievement.new
    @resume = Resume.find_by_user_id(current_user.id)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @achievement }
    end
  end

  # GET /articles/1/edit
  def edit
    @achievement = Achievement.find(params[:id])
    @resume = Resume.find_by_user_id(current_user.id)

  end

  # POST /articles
  # POST /articles.json
  def create
    @resume = Resume.find_by_user_id(current_user.id)
    @achievement = Achievement.new(params[:achievement])
    respond_to do |format|
      if @achievement.save
        format.html { redirect_to achievements_path, notice: 'achievement was successfully created.' }
        format.json { render json: @achievement, status: :created, location: @achievement }
      else
        format.html { render action: "new" }
        format.json { render json: @achievement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
	@achievement = Achievement.find(params[:id])
    respond_to do |format|
      if @achievement.update_attributes(params[:achievement])
        format.html { redirect_to achievements_path, notice: 'achievement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @achievement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @achievement = Achievement.find(params[:id])
    @achievement.destroy
    respond_to do |format|
      format.html { redirect_to achievements_path }
      format.json { head :no_content }
    end
  end
end

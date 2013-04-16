class ExperiencesController < InheritedResources::Base
 # def index
 #   @experiences = Experience.where(:user_id => current_user.id) 

#    respond_to do |format|
#      format.html # index.html.erb
#      format.json { render json: @experiences }
#    end
#  end

	before_filter :authenticate_user!
  # GET /articles
  # GET /articles.json
  def index
    @experiences = Experience.all.reverse 

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @experiences }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @experience = Experience.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @experience }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @experience = Experience.new
    @resume = Resume.find_by_user_id(current_user.id)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @experience }
    end
  end

  # GET /articles/1/edit
  def edit
    @experience = Experience.find(params[:id])
    @resume = Resume.find_by_user_id(current_user.id)

  end

  # POST /articles
  # POST /articles.json
  def create
    @resume = Resume.find_by_user_id(current_user.id)
    @experience = Experience.new(params[:experience])
    respond_to do |format|
      if @experience.save
        format.html { redirect_to experiences_path, notice: 'experience was successfully created.' }
        format.json { render json: @experience, status: :created, location: @experience }
      else
        format.html { render action: "new" }
        format.json { render json: @experience.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
	@experience = Experience.find(params[:id])
    respond_to do |format|
      if @experience.update_attributes(params[:experience])
        format.html { redirect_to experiences_path, notice: 'experience was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @experience.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @experience = Experience.find(params[:id])
    @experience.destroy
    respond_to do |format|
      format.html { redirect_to experiences_path }
      format.json { head :no_content }
    end
  end
end

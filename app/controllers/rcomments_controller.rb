class RcommentsController < ApplicationController
  #load_and_authorize_resource
  # GET /rcomments
  # GET /rcomments.json
  def index
    @rcomments = Rcomment.scoped
    @rcomment = Rcomment.new
  end

  # GET /rcomments/1
  # GET /rcomments/1.json
  def show
    @rcomment = Rcomment.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rcomment }
    end
  end

  # GET /rcomments/new
  # GET /rcomments/new.json
  def new
    @rcomment = current_user.rcomments.new(:parent_id => params[:parent_id], :resource_id => params[:resource_id])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rcomment }
    end
  end


  # GET /rcomments/1/edit
  def edit
    @rcomment = Rcomment.find(params[:id])
  end

  def forresource
    resource_id = params[:id]
    @resource = Resource.find_by_id(resource_id)
    @rcomments = @resource.rcomments.scoped
    @rcomment = @resource.rcomments.new
  end

  # POST /rcomments
  # POST /rcomments.json
  def create
    resource_id = params[:rcomment][:resource_id]
    @resource = Resource.find(resource_id)
    @rcomment = current_user.rcomments.new(:resource => @resource, :parent_id => params[:rcomment][:parent_id], :content => params[:rcomment][:content])
    respond_to do |format|
      if @rcomment.save
        format.html { redirect_to @resource, notice: 'Comment was successfully created.' }
        @rcomments = Rcomment.where(:resource_id => resource_id)
        format.json { render :status=>200, :json=>{:success=>true, :rcomments => @rcomments}}
        # @rcomment.create_activity :create, owner: current_user, recipient: r
      else
        format.html { render action: "new" }
        format.json { render json: @rcomment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rcomments/1
  # PUT /rcomments/1.json
  def update
    @rcomment = Rcomment.find(params[:id])

    respond_to do |format|
      if @rcomment.update_attributes(params[:rcomment])
        format.html { redirect_to @rcomment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @rcomment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rcomments/1
  # DELETE /rcomments/1.json
  def destroy
    @rcomment = Rcomment.find(params[:id])
    @rcomment.destroy

    respond_to do |format|
      format.html { redirect_to rcomments_url }
      format.json { head :no_content }
    end
  end
end
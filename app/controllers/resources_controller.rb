require 'will_paginate/array'
require 'google/api_client'
require 'profanity_filter'

class ResourcesController < ApplicationController
  load_and_authorize_resource

  def index
    @resources = Resource.all

  end

  def show
    @resource = Resource.find(params[:id])
    @reputation = @resource.reputation_for(:votes).to_i
    @rcomments = @resource.rcomments.scoped
    @rcomment = @resource.rcomments.new
    respond_to do |format|
      format.html
      format.json { render :status=>200, :json=>{:resource=>@resource, :reputation =>@reputation, :rcomments => @rcomments}}
    end
  end

  def create
    # Usability concern here... need to make sure that they are redirected back here once they log in or something
    if current_user == nil
      flash.keep
      flash[:error] = "You must log in to submit a resource!"
      redirect_to home_path
      return

    else
      params[:resource][:user_id] = current_user.id
    end

    # If no link is provided, it is a question
    if(params[:resource][:link] != nil)
      # Not a question, check to see if this resource unique
      params[:resource][:link] = PostRank::URI.clean(params[:resource][:link])
      if Resource.unique_link?(params[:resource][:link])
        @resource = Resource.new(params[:resource])
        @resource.update_attributes(:active => true)
        @resource[:youtubeID] = Resource.isYoutube(@resource[:link])
        @resource.save
        Resource.upload_image(@resource)
      else
        flash[:error] = "This resource has already been added!"
      end
      # No link provided, so this must be a question

    else

      @resource = Resource.new(params[:resource])
      @resource.update_attributes(:active => true)
      @resource.save
      @resource.update_attribute(:link, "/resources/"+@resource.id.to_s)
    end
    #@authen = Authentication.find_by_user_id_and_provider(current_user.id, 'facebook')
    if(!current_user.facebook.access_token.nil? && current_user.publish_actions)
      current_user.facebook.put_wall_post("I posted a resource on www.knowledgethief.com! Go Check it out!")
    end
    redirect_to home_path
  end

  def vote
    value = params[:type] == "up" ? 5 : -3
    @resource = Resource.find(params[:id])
    @resource.add_or_update_evaluation(:votes, value, current_user)

    # Grant the user moderator role if they have 10000 points and aren't already an admin
    # Test it on 5 points for now.
    if current_user.reputation_for(:votes) > 10 && current_user.role != "admin"
      current_user.role = "moderator"
    end
    respond_to do |format|
      format.html { redirect_to :back, notice: "Thank you for voting" }
      format.json { render :status=>200, :json=>{:success=>true}}
    end
    if !current_user.nil?
      if(!current_user.facebook.access_token.nil?)
        current_user.facebook.put_wall_post("I vote on a resource on www.knowledgethief.com")
      end
    end
  end

  def search
    # params[:q] is the users query
    # filter out profanity from the query
    params[:q] = ProfanityFilter::Base.clean(params[:q],'stars')

    # Log the user's search
    u_id = current_user == nil ? 0 : current_user.id

    # Make sure google(q, filter) is run first so the sort encompasses those results as well.
    # Make sure google(q, filter) is run first so the sort encompasses those results as well.
    filter = "video"
    if params[:filter] && !params[:filter].blank?
      filter = params[:filter].downcase
    end

    # Change this second parameter to filter when we figure out the organzation.
    ############ google(params[:q], filter) ####################################
    Resource.google(params[:q], filter)

    unless params[:q].blank?
      @resources = Resource.full_search(params[:q])
    else
      @resources = Resource.all
    end

    @resources = @resources.reject!{|r| !r.media_type.eql? params[:filter].downcase } unless params[:filter].blank?

    unless params[:sort].blank?
      case params[:sort].downcase
        when 'newest'
        then @resources = @resources.sort_by{|r| r.created_at}
        when 'votes'
        then @resources = @resources.sort_by!{|r| r.reputation_for(:votes).to_i}.reverse
      end
    end
    @resources = @resources.paginate(:page => (params[:page] || 1), :per_page => 15) unless @resources.nil?
  end

end

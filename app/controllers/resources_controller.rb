require 'will_paginate/array'

class ResourcesController < ApplicationController
  def index
      @resources = Resource.all
  end
  
  def create

    # Usability concern here... need to make sure that they are redirected back here once they log in or something
    if current_user == nil
      flash[:alert] = "You must log in to submit a resource!"
      redirect_to resources_path
      return
    else
      params[:resource][:user_id] = current_user.id
    end
    

    # Check to see if this resource unique
    params[:resource][:link] = Post::URI.clean(params[:resource][:link])
    if unique_link?(params[:resource][:link])
      @resource = Resource.new(params[:resource])
      @resource[:youtubeID] = self.isYoutube(@resource[:link])
      @resource.save
    else
      flash[:alert] = "This resource has already been added!"
    end
    redirect_to resources_path
  end
  
  def vote
    value = params[:type] == "up" ? 1 : -1
    @resource = Resource.find(params[:id])
    @resource.add_or_update_evaluation(:votes, value, current_user)
    respond_to do |format|  
        format.html { redirect_to :back, notice: "Thank you for voting" }  
        format.json { render :status=>200, :json=>{:success=>true}}  
    end
  end
  
  def isYoutube(youtube_url)
    regex = %r{http://www.youtube.com}
    if youtube_url[regex]
      youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      youtube_id = $5
      thumbnail_Link = "http://img.youtube.com/vi/#{youtube_id}/1.jpg"
    else
      thumbnail_Link = nil
    end
    thumbnail_Link
  end

  def unique_link?(url)
    Resource.find_by_link(url) == nil
  end
  
  def search
     @resource = Resource.full_search(params[:q])
   #  raise params.to_s
     @resource = @resource.reject!{|r| !r.media_type.eql? params[:filter][0][:media_type].downcase } if params[:filter] && !params[:filter][0][:media_type].blank?

     if params[:filter] 
      case params[:filter][0][:sort].downcase 
      when 'newest'
         then @resource = @resource.sort_by{|r| r.created_at}
      when 'votes'
         then @resource = @resource.sort_by!{|r| r.reputation_for(:votes).to_i}.reverse
      else
      end
     end

     @resource = @resource.paginate(:page => (params[:page] || 1), :per_page => 15)   
  end 
end

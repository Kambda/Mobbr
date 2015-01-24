class Mobbr::ProjectController < ApplicationController
  include Gitlab::Access
  
  skip_before_filter :authenticate_user!
  def initialize 
   @data  = { participants: []}  
  end
  
  def show 
  if !params[:group].nil? && !params[:project].nil? && !params[:id].nil?
   project = _projects.find_by(path: params[:project]) 
   if project
     @group.group_members.each do  |member|
       rol = nil
       Gitlab::Access.options.keys.collect{|x| rol =  x if Gitlab::Access.options[x] == member.access_level }
        @data[:participants].push({
            :id => member.user.email,
            :role =>  rol ,
             :share => '3'
        })
     end
   end
  end
    render :json => @data 
  end
  
  def issues    
    render :json => @data 
  end
  
  def merge_requests
    
  end
  
  def milestone
    
  end
  
  def _projects
    @project ||=  _groups.projects
  end
  
  def _groups
    @group   ||= Group.find_by(path: params[:group])
  end
  
  
end

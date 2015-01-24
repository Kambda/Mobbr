class Mobbr::ProjectController < ApplicationController
  include Gitlab::Access
  
  skip_before_filter :authenticate_user!
  def initialize 
   @data  = { participants: []}  
  end
  
  def show 
  if !params[:group].nil? && !params[:project].nil?
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
    if !params[:group].nil? && !params[:project].nil? && !params[:id].nil?
      @issue = _issue.find_by!(iid: params[:id])
      if @issue
         @issue.participants.each do |member|
           rol = nil
           @group.group_members.each do  |memb|
            if member.email == memb.user.email
              Gitlab::Access.options.keys.collect{|x| rol =  x if Gitlab::Access.options[x] == memb.access_level}
              Gitlab::Access.options.keys.collect{|x| rol =  '' if  memb.access_level.blank?}
            end
           end
          
          @data[:participants].push({
              :id => member.email,
              :role =>  rol ,
              :share => '3'
           })           
         end
        render :json => @data
      end
    end
  end
  
  def merge_requests
    if !params[:group].nil? && !params[:project].nil? && !params[:id].nil?
      @merge_request = _merge_request.find_by!(iid: params[:id])
      if @merge_request
         @merge_request.participants.each do |member|
           rol = nil
           @group.group_members.each do  |memb|
            if member.email == memb.user.email
              Gitlab::Access.options.keys.collect{|x| rol =  x if Gitlab::Access.options[x] == memb.access_level}
              Gitlab::Access.options.keys.collect{|x| rol =  '' if  memb.access_level.blank?}
            end
           end
          
          @data[:participants].push({
              :id => member.email,
              :role =>  rol ,
              :share => '3'
           })           
         end
        render :json => @data
      end
    end
  end
  
  def milestone
    if !params[:group].nil? && !params[:project].nil? && !params[:id].nil?
      @milestone = _milestone.find_by!(iid: params[:id])
      if @milestone
         @milestone.participants.each do |member|
           rol = nil
           @group.group_members.each do  |memb|
            if member.email == memb.user.email
              Gitlab::Access.options.keys.collect{|x| rol =  x if Gitlab::Access.options[x] == memb.access_level}
              Gitlab::Access.options.keys.collect{|x| rol =  '' if  memb.access_level.blank?}
            end
           end
          
          @data[:participants].push({
              :id => member.email,
              :role =>  rol ,
              :share => '3'
           })           
         end
        render :json => @data
      end
    end
   
  end
  
  def _merge_request
    @proj =    _projects.find_by(path: params[:project])
    @merge_request = @proj.merge_requests
  end

  def _milestone
    @proj =    _projects.find_by(path: params[:project])
    @milestone = @proj.milestones

  end
  
  def _issue
    @proj =    _projects.find_by(path: params[:project])
    @issue = @proj.issues

  end
  
  def _projects
    @project =  _groups.projects
  end
  
  def _groups
    @group   = Group.find_by(path: params[:group])
  end

  
end

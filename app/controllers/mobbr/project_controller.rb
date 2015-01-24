class Mobbr::ProjectController < ApplicationController
  skip_before_filter :authenticate_user!
  def initialize 
   @data  = { participants: []}  
  end
  
  def show 
  if !params[:group].nil? && !params[:project].nil?
  
   
  end
    render :json => @data 
  end
  
  def issues    
  
  end
  
  def merge_requests
    
  end
  
  def milestone
    
  end
end

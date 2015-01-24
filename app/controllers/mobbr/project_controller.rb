class Mobbr::ProjectController < ApplicationController
  skip_before_filter :authenticate_user!
  def initialize 
   @data  = { participants: []}  
  end
  
  def show 
    Project.all.each do |project|
      project.milestones.each do |mileston|
        mileston.participants.each do |participant|
         @data[:participants].push({
             :id => participant.email,
             :role => "coder",
             :share => "3"
         })
       end
      end
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

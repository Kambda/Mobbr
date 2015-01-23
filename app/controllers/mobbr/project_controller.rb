class Mobbr::ProjectController < ApplicationController
  
  def initialize 
   @data  = { participants: []}  
  end
  
  def show 
    Project.where(archived: false) do |project|
      project.milestone.participants.each do |participant|
        @data[:participants].push({
            :id => participant.email,
            :role => "coder",
            :share => "3"
        })
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

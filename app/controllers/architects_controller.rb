class ArchitectsController < ApplicationController

  skip_before_action :verify_authenticity_token, nly: %i[create update] # to-do create separate api for external use

  def index
    if params[:id] != nil
     render status: 200, json: Architect.find_by_id(params[:id])
    else        
     render status: 200, json: Architect.all
    end
  end

  def create
    puts "Create the architect request..."
    @ArchitectDetails = Architect.new("architect_id" => params[:architect_id] , "architect_name" => params[:architect_name])
    @ArchitectDetails.save
    render status: 200, json: Architect.all
  end

  def update
  end

  def delete
  end
end

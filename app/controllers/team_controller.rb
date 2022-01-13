class TeamController < ApplicationController

  skip_before_action :verify_authenticity_token, nly: %i[create update] # to-do create separate api for external use

  def index
    if params[:id] != nil
      render status: 200, json: Team.find_by_id(params[:id])
    else        
      render status: 200, json: Team.all
    end
  end

  def create

    project_id = getProjectId(params[:project_key])
    owner_id = getOwnerId(params[:manager_id])

    @TeamDetails = Team.new("manager_id" => params[:manager_id] , "manager_name" => params[:manager_name] , "team_count" => params[:team_count] , "total_bandwidth" => params[:total_bandwidth], "allocated_bandwidth" => params[:allocated_bandwidth], "project_id" => project_id, "project_key" => params[:project_key], "owner_id" => owner_id)
    @TeamDetails.save
    render status: 200, json: Team.all
  end

  def update

    teamDetails = Team.find_by_id(params[:id])
    params[:team].each do |obj|
      if obj[0] != 'updated_at' && obj[0] != 'created_at' && obj[0] != 'created_by' && obj[0] != 'manager_name' && obj[0] != 'manager_id'
        teamDetails[obj[0]] = obj[1]
      end
    end

    teamDetails.save
    render status: 200, json: Team.all
  end

  def getProjectId(project_key)

    case project_key
      when "FD"
        return "488"
      when "FRESHCALL"
        return "594"
      when "FC"
        return "307"
      when "FBOTS"
        return "280"
      else
        return " ";
      end

  end

  def getOwnerId(manager_id)
    "49505"
  end

  def delete
    teamDetails = Team.find_by_id(params[:id])
    teamDetails.delete
    render status: 200, json: Team.all
  end
end

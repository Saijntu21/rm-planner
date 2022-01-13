class ThemeController < ApplicationController

  skip_before_action :verify_authenticity_token, nly: %i[create update multiple_assignment] # to-do create separate api for external use
  
  def index
    if params[:id] != nil
      render status: 200, json: Theme.find_by_id(params[:id])
    else        
      render status: 200, json: Theme.all
    end
  end

  def create
    puts "Create the Themes request..."
    @ThemesDetails = Theme.new("name" => params[:name])
    @ThemesDetails.save
    render status: 200, json: Theme.all
  end

  def update
    themesDetails = Theme.find_by_id(params[:id])
    themesDetails.update(:name => params[:name])
    themesDetails.save
    render status: 200, json: Theme.all
  end

  def theme_status
    totPW = 0
    teamDetails = Team.all
    teamDetails.each do |team|
      totPW = totPW + team.total_bandwidth
    end

    themePW = 0
    epicCnt = 0
    epicDetails = Epic.where(:theme_id => params[:theme_id])
    epicDetails.each do |epic|
      themePW = themePW + epic.eta
      epicCnt = epicCnt + 1
    end

    responseData = {}
    responseData[:theme_bandwidth] = themePW
    responseData[:total_bandwidth] = totPW
    responseData[:epic_count] = epicCnt
    render status: 200, json: responseData
  end

  def delete
  end
end
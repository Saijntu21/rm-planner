class EpicController < ApplicationController
  
  skip_before_action :verify_authenticity_token, only: %i[create update multiple_assignment epicListByQuarter create_freshrelease_ticket] # to-do create separate api for external use

  def index
    if params[:id] != nil
      render status: 200, json: Epic.find_by_id(params[:id])
    elsif params[:manager_id] != nil
      render status: 200, json: Epic.where(:assigned_to => params[:manager_id]).order('epics.updated_at desc').all
    elsif params[:theme_id] != nil
      render status: 200, json: Epic.where(:theme_id => params[:theme_id]).order('epics.updated_at desc').all
    else
      epicDetails = Epic.all
      epicDetails = epicDetails.where(:quarter => params[:quarter]) if params[:quarter] != nil
      epicDetails = epicDetails.where(:bu_unit => params[:bu_unit]) if params[:bu_unit] != nil
      epicDetails = epicDetails.where(:status => params[:status]) if params[:status] != nil
      render status: 200, json: epicDetails.order('epics.updated_at desc').all     
    end
  end

  def create
    
    begin
      status = 2
      status = 3 if params[:i2p_document] != nil
      status = 4 if params[:assigned_to] != nil

      architectDetails = Architect.where(:architect_id => params[:architect_id])
      architect_name = architectDetails.pluck(:architect_name)[0]
      themeDetails = Theme.where(:id => params[:theme_id])
      theme_name = themeDetails.pluck(:name)[0]

      created_by = "SAI"
      created_by = params[:created_by] if params[:created_by] != nil

      epicDetails = Epic.new("name" =>  params[:name] , "created_by" => created_by , "description" =>  params[:description] , "epic_type" => params[:epic_type] , "priority" => params[:priority] , "customer_name" => params[:customer_name], "quarter" => params[:quarter] , "i2p_document" => params[:i2p_document] , "bu_unit" => params[:bu_unit] , "dependent_workflow" => params[:dependent_workflow] , "impact" => params[:impact] , "eta" =>  params[:eta], "architect_name" => architect_name, "architect_id" => params[:architect_id], "status" => status, "theme_id" => params[:theme_id], "theme_name"=> theme_name)
      epicDetails.save

      WishList.find_by_id(params[:wish_list_id]).delete if params[:wish_list_id] != nil

      render status: 200, json: Epic.all

    rescue Exception => e
      puts "Exception at Create Epic :: Message ::#{e.message}"
      render status: 500, json: { success: false, message: e.message }
    end
  end

  def update

    begin
      puts "Update the Epic request... "
      epicDetails = Epic.find_by_id(params[:id])

      params[:epic].each do |obj|
        if obj[0] != 'updated_at' && obj[0] != 'created_at' && obj[0] != 'created_by'
         epicDetails[obj[0]] = obj[1]
        end
      end

      epicDetails.save

      if params[:architect_id] != nil
        architect_name = Architect.where(:architect_id => params[:architect_id]).pluck(:architect_name)[0]
        epicDetails.update(:architect_name => architect_name)
      end

      if params[:theme_id] != nil
        theme_name = Theme.where(:id => params[:theme_id]).pluck(:name)[0]
        epicDetails.update(:theme_name => theme_name)
      end

      render status: 200, json: Epic.all
    rescue Exception => e
      puts "Exception at Create Epic :: Message ::#{e.message}"
      render status: 500, json: { success: false, message: e.message }
    end
  end


  def multiple_assignment

    puts "multiple_assignment request from Epic... "
    resource_avail = 0
    epicDetails = Epic.where("id IN (?)", JSON(params[:epic_ids]))

    ActiveRecord::Base.transaction do
      epicDetails.each do |epic|
        epicEta = 0
        epicEta = epic.eta if epic.eta != nil
        resource_avail += epicEta if epic.eta != nil
        if epic.assigned_to != nil
          teamDetails = Team.where(:manager_id => epic.assigned_to)
          allocated_bandwidth = teamDetails.pluck(:allocated_bandwidth)[0]
          teamDetails.update(allocated_bandwidth: allocated_bandwidth-epicEta)
        end
      end

      if params[:manager_id] != nil
        teamDetails = Team.where(:manager_id => params[:manager_id])
        #epicDetails.update_all({:assigned_to => params[:manager_id], :manager_name => teamDetails.pluck(:manager_name)[0], :status => 4})
        epicDetails.update(assigned_to: params[:manager_id])
        epicDetails.update(manager_name: teamDetails.pluck(:manager_name)[0])
        epicDetails.update(status: 4)
        allocated_bandwidth = teamDetails.pluck(:allocated_bandwidth)[0]
        teamDetails.update(allocated_bandwidth: allocated_bandwidth+resource_avail)
      end
    end

    render status: 200, json: Epic.all
  end

  def epicStatusByQuarter

    epicDetails = Epic.all
    epicDetails = epicDetails.where(:quarter => params[:quarter]) if params[:quarter] != nil
    epicDetails = epicDetails.where(:bu_unit => params[:bu_unit]) if params[:bu_unit] != nil

    wishListDetails = WishList.all
    wishListDetails = wishListDetails.where(:quarter => params[:quarter]) if params[:quarter] != nil
    wishListDetails = wishListDetails.where(:bu_unit => params[:bu_unit]) if params[:bu_unit] != nil

    responseData = {}
    responseData[:open_cnt] = wishListDetails.where(:status => 1).count
    responseData[:inprogress_cnt] = epicDetails.where(:status => 2).count
    responseData[:completed_nt] = epicDetails.where(:status => 3).count
    responseData[:assigned_cnt] = epicDetails.where(:status => 4).count
    render status: 200, json: responseData
  end

  def delete
    puts "Delete the Epic request..." 
    epicDetails = Epic.find_by_id(params[:epic_ids])
    epicDetails.delete
    render status: 200, json: Epic.all
  end

  def create_freshrelease_ticket
    
    epicDetails = Epic.where("id IN (?)", JSON(params[:epic_ids]))

    manager_id = params[:manager_id]

    epicDetails.each do |epicInfo|

      managerId = epicInfo.assigned_to
      teamInfo = Team.where(:manager_id => managerId)

      epic_tags = []
      epic_tags[0] = tag_info(epicInfo.quarter)

      bodyText = {}

      bodyText[:title] = epicInfo.name
      bodyText[:key] = teamInfo.pluck(:project_key)[0]
      #bodyText[:key] = "FRESHCALL"
      bodyText[:description] = epicInfo.description
      bodyText[:issue_type_id] = "11"
      bodyText[:project_id] = teamInfo.pluck(:project_id)[0]
      #bodyText[:project_id] = "594"
      
      bodyText[:tags] = epic_tags
      bodyText[:owner_id] = teamInfo.pluck(:owner_id)[0]
      #bodyText[:owner_id] = "49505"


      url = "https://freshworks.freshrelease.com/"+ bodyText[:key] +"/issues"
      uri = URI(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.path, initheader = request_headers)


      bodyT = {}
      bodyT[:issue] = bodyText
      request.body = bodyT.to_json

      response = http.request(request)
      body = JSON.parse(response.body)

      puts "response :::: #{body}}"
      epicInfo.update(:fresh_release_id => body['issue']['key'])

    end

    render status: 200, json: Epic.where(:assigned_to => manager_id).order('epics.updated_at desc').all
  end

  def tag_info(quarter_info)
    puts "quarter_info ::: #{quarter_info}"
    case quarter_info
      when 1
        return "Q1 2021"
      when 2
        return "Q2 2021"
      when 3
        return "Q3 2021"
      when 4
        return "Q4 2021"
      else
        return " ";
      end
  end

  def request_headers
    { 'Content-Type': 'application/json', 'Authorization': 'Token KDBE50ARip-93Zq9vJjjZA' }
  end
end

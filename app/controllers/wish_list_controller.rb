class WishListController < ApplicationController

  skip_before_action :verify_authenticity_token, nly: %i[create update] # to-do create separate api for external use

  def index
    if params[:id] != nil
      render status: 200, json: WishList.find_by_id(params[:id])
    else
      wishListDetails = WishList.all
      wishListDetails = WishList.where(:quarter => params[:quarter]) if params[:quarter] != nil
      wishListDetails = WishList.where(:bu_unit => params[:bu_unit]) if params[:bu_unit] != nil
      wishListDetails = WishList.where(:status => params[:status]) if params[:status] != nil
      render status: 200, json: wishListDetails.order('wish_lists.updated_at desc').all     
    end
  end

  def create
    puts "Create the WishList request..."
    status = 1
    created_by = "SAI"
    created_by = params[:created_by] if params[:created_by] != nil
    @WishListDetails = WishList.new("name" => params[:name] , "created_by" => created_by , "wish_list_type" => params[:wish_list_type] , "description" =>  params[:description] , "priority" => params[:priority] , "customer_name" => params[:customer_name], "quarter" => params[:quarter], "bu_unit" => params[:bu_unit] , "dependent_workflow" => params[:dependent_workflow] , "impact" => params[:impact] , "status" => status)
    @WishListDetails.save
    render status: 200, json: WishList.all
  end

  def multi_create
    puts "Create the WishList Multiple Create... #{params}"
    params[:Sheet1].each do |obj|
      if obj[:Epic] != nil && obj[:Impact] != nil
        puts "obj :::::::: && SAI KUMAR #{obj[:Epic]}"
        @WishListDetails = WishList.new("name" => obj[:Epic] , "created_by" => "Sai" , "wish_list_type" => 1 , "description" =>  obj[:Epic] , "priority" => 2 , "quarter" => 1, "bu_unit" => 1 , "dependent_workflow" => obj[:Area] , "impact" => obj[:Impact].truncate(250) , "status" => 1)
        #@epicDetails = Epic.new("name" =>  obj[:Epics].truncate(250) , "created_by" => "Sai" , "description" =>  obj[:Epics].truncate(250) , "epic_type" => 2, "priority" => 3 , "quarter" => 1 , "bu_unit" => 1 , "dependent_workflow" => obj[:Dependencies] , "eta" =>  20, "architect_name" => "Thana Shyam", "architect_id" => 0007, "status" => 1)
        #@epicDetails = Epic.new("name" =>  params[:Epics] , "created_by" => "Sai , "description" =>  params[:Epics] , "epic_type" => 2, "priority" => 3 , "quarter" => 1 , "bu_unit" => 1 , "dependent_workflow" => params[:Dependencies] , "eta" =>  20, "architect_id" => 0007, "status" => 1)
        @WishListDetails.save
      end
    end

   # status = 1
   # @WishListDetails = WishList.new("name" => params[:name] , "created_by" => params[:created_by] , "wish_list_type" => params[:wish_list_type] , "description" =>  params[:description] , "priority" => params[:priority] , "customer_name" => params[:customer_name], "quarter" => params[:quarter], "bu_unit" => params[:bu_unit] , "dependent_workflow" => params[:dependent_workflow] , "impact" => params[:impact] , "status" => status)
   # @WishListDetails.save
    render status: 200, json: Epic.all
  end

  def update

    puts "Update the WishList request..." 

    wishListDetails = WishList.find_by_id(params[:id])

    params[:wish_list].each do |obj|
       if obj[0] != 'updated_at' && obj[0] != 'created_at' && obj[0] != 'created_by'
        wishListDetails[obj[0]] = obj[1]
      end
    end

    wishListDetails.save
    render status: 200, json: WishList.all
  end

  def delete
    puts "Delete the WishList request..." 
    wishListDetails = WishList.find_by_id(params[:id])
    wishListDetails.delete
    render status: 200, json: WishList.all
  end

end

class HomeController < ApplicationController

  def index
    @channel = (1000000000 + rand(999999999999)).to_s()
  end

  def update

   	@links = Array.new;

  	memberids = ["hhcabins", 
  				 "ValleyViewCabins", 
  				 "barringer", 
  				 "timberridge", 
  				 "harvestmoon", 
  				 "Callie", 
  				 "turtlehill", 
  				 "bttrswt", 
  				 "cabinsvista",
  				 "bnc",
  				 "crockettsrun",
           "GoodEarth",
           "foxglove",
           "BourbanRidge",
           "cola",
           "getaway",
           "CedarPinesCabins",
           "bearsden",
           "backwoodsretreat",
           "lazy"]

        beginDate = params[:bdate].first
        endDate = params[:edate].first

  	memberids.each do |memberid|
      ReservationWorker.perform_async(memberid, params, beginDate, endDate, @links, params[:channel]);
    end
  end

end

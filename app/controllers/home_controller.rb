class HomeController < ApplicationController

  def index
  	  @links = Array.new;

  end

  def update

   	@links = Array.new; 
   	browser = Mechanize.new; 


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

    puts beginDate
    puts endDate

  	memberids.each do |memberid|



  		page = browser.post('https://reserve.reservationsonline.com/bookings/resbook.asp', {"bdate" => beginDate, 
                                                                                          "edate" => endDate, 
                                                                                          "units" => params[:units], 
                                                                                          "guests" => params[:guests], 
                                                                                          "children1" => params[:children], 
                                                                                          "children2" => 0, 
                                                                                          "children3" => 0, 
                                                                                          "pets" => params[:pets], 
                                                                                          "memberid" => memberid, 
                                                                                          "javaon" => "Y", 
                                                                                          "pf" => "",
                                                                                          "action" => "pickrooms"})

	  	page.search("div#room").each do |room|
	  		puts room.search(".name").text
        image = room.search("img");
        imgSrc = "https://reserve.reservationsonline.com" + image.attr('src');
			tmp = { :title => room.search(".name").text, 
					:description => room.search(".description").text,
					:rates => room.search(".rates").text,
					:image => imgSrc,
          :bookLink => "https://reserve.reservationsonline.com/bookings/resbook.asp?javaon=Y&action=pickrooms&memberid=" + memberid + "&bdate=" + URI.escape(beginDate) + "&edate=" + URI.escape(endDate)}
	  		@links << tmp
	  	end
	end
  end

end

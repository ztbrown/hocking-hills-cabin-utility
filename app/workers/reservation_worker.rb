require 'private_pub'

class ReservationWorker
	include Sidekiq::Worker
	sidekiq_options retry: false

	def perform(memberid, params, beginDate, endDate, links, channel)
		
		browser = Mechanize.new; 

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
        id = 0 
          room.search('a').each do |link|
            onclickText = link.attr('onclick')
            if onclickText.class != NilClass
              id = onclickText.scan(/\b\d{5}\b/)
            end
          end
        image = room.search("img");
        imgSrc = "https://reserve.reservationsonline.com" + image.attr('src');
			tmp = { :title => room.search(".name").text, 
					:description => room.search(".description").text,
					:rates => room.search(".rates").text,
					:image => imgSrc,
          :roomid => id[0],
          :bookLink => "https://reserve.reservationsonline.com/bookings/resbook.asp?javaon=Y&action=pickrooms&memberid=" + memberid + "&bdate=" + URI.escape(beginDate) + "&edate=" + URI.escape(endDate)}
	  		if tmp[:title].is_a? String
          puts tmp[:title]
          PrivatePub.publish_to("/messages/" + channel, "appendNewResult('#{tmp[:title]}', '#{tmp[:description]}', '#{tmp[:rates]}', '#{tmp[:image]}')")
        end
        links << tmp
	  	end
	end
	
end

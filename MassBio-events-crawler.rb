require 'nokogiri'
require 'open-uri'
require 'pry'


# class MassBio
#   def self.scrape
    MassBio_Events = "https://www.massbio.org/events/listing?eventHost=massbio"
    page = Nokogiri::HTML(open(MassBio_Events))

    events = page.css("div.Primary-Info")
    massbio_events = []

    events.each do |event|
      name = event.css("a.Listing-Title.Listing-Link").text
      date = event.css("span.Property.date")[0].text
      if event.css("span.Property.time")[0].nil?
        start_time = "12:00PM"
      else
        start_time = event.css("span.Property.time")[0].text
      end
      if event.css("span.Property.time")[1].nil?
        end_time = "12:00PM"
      else
        end_time = event.css("span.Property.time")[1].text
      end
      address = event.css("address.Address").text.gsub(/\s+/, " ")
      if event.css("p.Abstract")
        rough_description = event.css("p.Abstract").text.strip
        delete = event.css("a.Listing-Link.detailLink").text
        description =  rough_description.chomp!(delete).strip
      end

      massbio_event = {
        name: name,
        date: date,
        start_time: start_time,
        end_time: end_time,
        address: address,
        description: description
      }

      massbio_events.push(massbio_event)
    end
    puts massbio_events
#   end
# end
#
# MassBio.scrape

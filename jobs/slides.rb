require 'net/http'
require 'uri'
require 'json'
require 'nokogiri'
require 'time'

class Slides
  @@uri ||= URI.parse(ENV['DASHBOARD_SLIDES_JSON'])

  def image_list
    Net::HTTP.new(@@uri.host, @@uri.port)
    response = Net::HTTP.get_response(@@uri)
    JSON.parse(response.body).map {|url|
      "#{ENV['DASHBOARD_SLIDES_HOST']}/#{url}"
    }
  end
end

slideshow = Slides.new

SCHEDULER.every '15m', :first_in => 0 do
  stale = Time.now + 45 * 60
  send_event('welcome', { image_list: slideshow.image_list, stale: stale.to_i })
end

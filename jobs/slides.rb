require 'net/http'
require 'uri'
require 'json'
require 'nokogiri'
require 'time'

class Slides
  @@uri ||= URI.parse(ENV['DASHBOARD_SLIDES_JSON'])

  def image_list
    Net::HTTP.new(@@uri.host, @@uri.port)
    slides_response = Net::HTTP.get_response(@@uri)

    JSON.parse(slides_response.body).map{ |slide_url| slide_url }
  end
end

slideshow = Slides.new

SCHEDULER.every '15m', :first_in => 0 do
  stale = Time.now + 45 * 60
  send_event('welcome', { image_list: slideshow.image_list, stale: stale.to_i })
end

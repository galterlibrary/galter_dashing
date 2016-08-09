require 'net/http'
require 'uri'
require 'json'
require 'nokogiri'
require 'time'

class Slides
  @@uri ||= URI.parse(ENV['DASHBOARD_SLIDES'])

  def get_images
    Net::HTTP.new(@@uri.host, @@uri.port)
    response = Net::HTTP.get_response(@@uri)
    content_json = JSON.parse(response.body)
    content_json['sections'].map{ |content| content['content'] }
  end

  def image_list
    images = []
    get_images.each do |section|
      images << Nokogiri::HTML(section).css('img').map{ |i| i['src'] }
    end
    images.flatten.map{ |x| @@uri.dup.tap { |u| u.path = x }.to_s }
  end
end

slideshow = Slides.new

SCHEDULER.every '15m', :first_in => 0 do
  stale = Time.now + 45 * 60
  send_event('welcome', { image_list: slideshow.image_list, stale: stale.to_i })
end

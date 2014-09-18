require 'net/http'
require 'time'
require 'json'

SCHEDULER.every '30m', :first_in => 0 do
  classes_uri = URI(ENV['COURSE_URI'])
  response = Net::HTTP.get_response(classes_uri)
  classes_json = JSON.parse(response.body)
  classes = []

  classes_json.each do |c|
    course_date = Time.parse(c['class_date']).localtime("-05:00").
      strftime('%A, %B %e, %Y %l:%M %p')
    classes << { 'label' => c['course']['title'], 'value' => course_date }
  end

  if classes.count == 0
    classes << { 'label' => 'No upcoming classes scheduled at this time',
      'value' => '' }
  end

  send_event('galter-classes', { items: classes })
end

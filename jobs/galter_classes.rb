require 'net/http'
require 'time'
require 'json'
require 'active_support/all'

SCHEDULER.every '30m', :first_in => 0 do
  classes_uri = URI(ENV['COURSE_URI'])
  response = Net::HTTP.get_response(classes_uri)
  classes_json = JSON.parse(response.body)
  classes = []

  classes_json.each do |c|
    Time.zone = 'Central Time (US & Canada)'
    course_date = Time.zone.parse(c['class_date']).strftime('%A, %m/%d/%Y')
    course_time = Time.zone.parse(c['class_date']).strftime('%l:%M %p')
    classes << { 'class' => c['course']['title'], 'date' => course_date,
      'time' => course_time }
  end

  if classes.count == 0
    classes << { 'label' => 'No upcoming classes scheduled at this time',
      'value' => '' }
  end

  send_event('galter-classes', { items: classes[0..3] })
end

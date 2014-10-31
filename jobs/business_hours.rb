require 'net/http'
require 'json'

SCHEDULER.every '30m', :first_in => 0 do
  response = Net::HTTP.get_response(URI(ENV['BUSINESS_HOURS']))
  business_hours = JSON.parse(response.body)
  if business_hours['closed_all_day'].present?
    closing_message = 'The library is closed today.'
  else
    closing_message = "The library closes at #{business_hours['close']}"
  end
  send_event('hours', { closing_time: closing_message })
end

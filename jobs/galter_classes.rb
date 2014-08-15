SCHEDULER.every '15m', :first_in => 0 do
  # example data: we'll need to pull from our app eventually.
  classes = [
    { "label" => "Endnote", "value" => "Thursday, August 21, 2014 12:00 PM" },
    { "label" => "PubMed", "value" => "Friday, August 22, 2014 12:00 PM" }
  ]

  send_event('galter-classes', { items: classes })
end

Dir.glob(File.dirname(__FILE__) + '/local_env.rb', &method(:require))

require 'dashing'

configure do
  set :auth_token, ENV['AUTH_TOKEN']

  helpers do
    def protected!
     # Put any authentication code you want in here.
     # This method is run before accessing any resource.
    end
  end
end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application

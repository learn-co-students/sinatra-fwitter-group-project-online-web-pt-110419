require './config/environment'

class TweetsController < ApplicationController
  configure do
    enable :sessions
    set :session_secret, "tweet_secret"
  end

end

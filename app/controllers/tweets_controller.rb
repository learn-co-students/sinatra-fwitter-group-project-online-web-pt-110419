require './config/environment'

class TweetsController < ApplicationController
 # configure do
    # enable :sessions
    # set :session_secret, "tweet_secret"
 # end
  
  get '/tweets' do 
    if logged_in?
      @tweets = Tweet.all
      @user = current_user
      erb :'tweets/tweets_index'
    else
      redirect '/login'
    end
  end
  
  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect to '/login'
    end
  end
  
  post '/tweets' do
    @user = current_user
    if params[:content].empty?
      redirect '/tweets/new'
    end
    @tweet = Tweet.create(:content => params[:content], :user_id => @user.id)
    redirect '/tweets'
  end
  
  get '/tweets/:id' do
    if !logged_in?
      redirect '/login'
    end
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show'
  end
  
  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if current_user.id != @tweet.user_id
        redirect '/tweets'
      else
        erb :'/tweets/edit'
      end
    else
      redirect '/login'
    end
  end
  
  patch '/tweets/:id' do
    tweet = current_user.tweets.find_by(:id => params[:id])
    if !params[:content].empty?
      tweet.update(:content => params[:content])
      redirect to "/tweets/#{params[:id]}"
    else
      redirect to "tweets/#{params[:id]}/edit"
    end
  end
  
  delete '/tweets/:id' do
    tweet = current_user.tweets.find_by(id: params[:id])
    if tweet && tweet.destroy
      redirect to '/tweets'
    else
      redirect to "/tweets/#{params[:id]}"
    end
  end
  
  

end

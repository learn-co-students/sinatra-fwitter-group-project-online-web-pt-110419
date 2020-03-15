class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      @session = session
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content] != ""
      @tweet = Tweet.create(content: params[:content])
      @user = User.find_by(id: session[:user_id])
      @user.tweets << @tweet
    end
    redirect '/tweets/new'
  end

  get '/tweets/:id' do
    @user = User.find_by(id: session[:user_id])
    if logged_in?
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      @user = User.find_by(id: session[:user_id])
      if @user == @tweet.user
        erb :'/tweets/edit'
      else
        redirect "/tweets"
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    @tweet.update(content: params[:content])
    redirect "/tweets/#{@tweet.id}/edit"
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    @tweet.destroy
    redirect '/tweets'
  end



end

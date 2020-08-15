class TweetsController < ApplicationController

    get '/tweets' do
        if !logged_in?
            redirect '/login'
         elsif logged_in?
            @tweets = Tweet.all
            @user = current_user #User.find(session[:user_id])
            erb :'tweets/index'
          end
    end

    get '/tweets/new' do
        if !logged_in?
            redirect '/login'
        end
        erb :'tweets/new'
    end

    post '/tweets' do
        user = current_user
        if params[:content].empty?
            redirect '/tweets/new' 
        end  
        @tweet = Tweet.create(content: params[:content], :user_id => user.id)
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
        if !logged_in?
            redirect '/login'
        end
         @tweet = Tweet.find(params[:id])
         if current_user.id != @tweet.user_id
             redirect '/tweets'
         end
        erb :'/tweets/edit'
    end

    patch '/tweets/:id' do
        tweet = current_user.tweets.find_by(id: params[:id])
        if !params[:content].empty?
            tweet.update(content: params[:content])

            redirect "/tweets/#{params[:id]}"
        else        
            redirect "/tweets/#{params[:id]}/edit"  
        end 
    end

    delete '/tweets/:id' do
        tweet = current_user.tweets.find_by(id: params[:id])
        if tweet && tweet.destroy
            redirect "/tweets"
        else
            redirect "/tweets/#{params[:id]}"
    end

    end


end

class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
        redirect '/tweets'
    else
        erb :'users/signup'
    end
  end

  post'/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save && @user.username != "" && @user.email != "" && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect '/tweets'
    else
        redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
        redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else !logged_in?
      redirect '/tweets'
    end
  end

  get '/users/:slug' do
    slug = params[:slug]
    @user = User.find_by_slug(slug)
    erb :"users/show"
  end

end

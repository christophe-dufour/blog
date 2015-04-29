class SessionsController < ApplicationController


  def index

  end

  def new
    redirect_to '/auth/google_oauth2'
  end

  def create
    auth = request.env["omniauth.auth"]

    reset_session
    if auth.info.email == Rails.application.secrets.admin_email
      session[:admin] = auth.info.email
      redirect_to admin_url, :notice => 'Signed in!'
    else
      redirect_to admin_url, :alert => "Authentication error: not good account"
    end
  end

  def destroy
    reset_session
    redirect_to admin_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to admin_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end

class SessionsController < ApplicationController
  def new; end

  def create
    session = param[:session]
    user = User.find_by email: session[:email].downcase
    if user && user.authenticate(session[:password])
      log_in_success user
    else
      log_in_fail
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  def log_in_success user
    log_in user
    redirect_to user
  end

  def log_in_fail
    flash.now[:danger] = t "error_login_message"
    render :new
  end
end

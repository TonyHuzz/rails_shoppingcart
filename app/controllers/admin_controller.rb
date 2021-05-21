class AdminController < ApplicationController

  def log_in
  end

  def log_out
    session[:current_user_id] = nil
  end

  def create_session
    user = User.find_by(email: params[:email], password: params[:password] )

    if user
      session[:current_user_id] = user.id
    end

    redirect_to action: :log_in
  end

  def encrypted(password)
    return "aaaaa" + password
  end


end

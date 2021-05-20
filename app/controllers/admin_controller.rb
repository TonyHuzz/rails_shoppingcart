class AdminController < ApplicationController

  def log_in
    @note = session[:note]
  end

  def log_out
    session[:note] = nil
  end

  def create_session
    user = User.find_by(email: params[:email], password: encrypted(params[:password]) )

    if user
      session[:note] = user.name
    end

    redirect_to action: :log_in
  end

  def encrypted(password)
    return "aaaaa" + password
  end


end

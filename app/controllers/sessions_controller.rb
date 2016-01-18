class SessionsController < ApplicationController
  def new
  end

  def create

    # user = User.from_omniauth(env["omniauth.auth"])
    # puts " ---------- session ----------------"
    # puts user.inspect
    # puts " ---------- end session ----------------"

    # if user.present?
    #   session[:user_id] = user.id
    #   redirect_to root_url
    # else
    #   puts"user---#{user.inspect}"
    #   flash[:notice] = user.errors
    #   redirect_to root_url
    # end
    
    

    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
       if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end

    else
      # Create an error message.
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end


  end


  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  
end
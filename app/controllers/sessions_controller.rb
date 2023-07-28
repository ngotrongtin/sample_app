class SessionsController < ApplicationController
  def new
  end

  def create 
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated? # just log in if user is actived
        # if user tick in the checkbox, we will remember that user or we will forget that user (unessesary, but why not)
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        log_in user
        redirect_back_or(user)
        # Log the user in and redirect to the user's show page.
      else
        message = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
    # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination' # Not quite right
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
 
end

class ApplicationController < ActionController::Base
    include SessionsHelper
    
    private 
    #check if a user is logged or not, if not, redirect to the login path
    def logged_in_user
        unless logged_in?
            store_location
            flash[:danger] = "Please log in."
            redirect_to login_url
        end
    end
end

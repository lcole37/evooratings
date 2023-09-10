class LandingPageController < ApplicationController
  def index
    # @users = User.all
    if session[:user_id]
      @user = User.find(params[:id])
    end
  end

end

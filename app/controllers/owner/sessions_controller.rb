class Owner::SessionsController < ApplicationController
  skip_authorization_check

  def create
    if params[:user][:name] == ENV['OWNER_USERNAME'] && params[:user][:password] == ENV['OWNER_PASSWORD']
      sign_in User.owner
    end

    if user_signed_in?
      redirect_to after_sign_in_path_for(:user)
    else
      flash[:alert] = 'Incorrect login information'
      render :new
    end
  end
end

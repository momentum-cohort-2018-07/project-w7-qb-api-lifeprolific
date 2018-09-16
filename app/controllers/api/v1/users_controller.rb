class Api::V1::UsersController < ApplicationController

  def request_token
    @user = User.find_by_username(params[:username])
    if @user && @user.authenticate(params[:password]) then
      render :json =>{
          :status => :authorized,
          :token => @user.api_token
      }
  else
      render :json => {
          :status => :unauthorized,
          :token => :forbidden
      }
  end
  end

end

class Api::V1::UsersController < ApplicationController

  before_action :set_user, only: [:show, :update, :destroy]

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

  def show
    @questions = @user.questions
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end

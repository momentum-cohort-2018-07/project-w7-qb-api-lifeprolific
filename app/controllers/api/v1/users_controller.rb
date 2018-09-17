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

  def create
    @user = User.new(params.permit(:username, :email, :password))
    if @user.save
      render :json => {
        status: :created,
        id: @user.id,
        token: @user.api_token
      }
    else
      render :json => {
        errors: @user.errors,
        status: :unprocessable_entity}
    end
  end

  def update
    if authenticate_token && authenticate_token.id == @user.id
      if @user.update(params.permit(:username, :email, :password).merge({id: authenticate_token.id}))
        render :json => {
          status: :updated, id: @user.id}
      else
        render :json => {
          errors: @user.errors,
          status: :unprocessable_entity}
      end
    else
      render :json => {
        error: "invalid authentication token",
      }
    end
  end

  def destroy
    if authenticate_token && authenticate_token.id == @user.id
      @user.destroy
      render :json => {
        status: :destroyed}
    else
      render :json => {
        error: "invalid authentication token",
      }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end

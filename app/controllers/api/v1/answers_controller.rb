class Api::V1::AnswersController < ApplicationController

  before_action :set_answer, only: [:update, :destroy]

  def create
    if authenticate_token
      @answer = Answer.new(params.permit(:body, :question_id).merge({user_id: authenticate_token.id}))
      if @answer.save
        render :json => {
          status: :created, id: @answer.id}
      else
        render :json => {
          errors: @answer.errors,
          status: :unprocessable_entity}
      end
    else
      render :json => {
        error: "invalid authentication token",
      }
    end
  end

  def update
    if authenticate_token && authenticate_token.id == @answer.user_id
      if @answer.update(params.permit(:body, :question_id).merge({user_id: authenticate_token.id}))
        render :json => {
          status: :updated, id: @answer.id}
      else
        render :json => {
          errors: @answer.errors,
          status: :unprocessable_entity}
      end
    else
      render :json => {
        error: "invalid authentication token",
      }
    end
  end

  def destroy
    if authenticate_token && authenticate_token.id == @answer.user_id
      @answer.destroy
      render :json => {
        status: :destroyed}
    else
      render :json => {
        error: "invalid authentication token",
      }
    end
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
    @question = @answer.question
  end
end

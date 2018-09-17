class Api::V1::QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :update, :destroy]

  def index
    @questions = Question.page(params[:page]).per(10)
  end

  def show
    @answers = Answer
                   .left_joins(:votes)
                   .group(:id)
                   .order('SUM(votes.value) DESC')
                   .where(question_id: @question.id)
  end

  def create
    if authenticate_token
      @question = Question.new(params.permit(:title, :body).merge({user_id: authenticate_token.id}))
      if @question.save
        render :json => {
          status: :created, id: @question.id}
      else
        render :json => {
          errors: @question.errors,
          status: :unprocessable_entity}
      end
    else
      render :json => {
        error: "invalid authentication token",
      }
    end
  end

  def update
    if authenticate_token && authenticate_token.id == @question.user_id
      if @question.update(params.permit(:title, :body).merge({user_id: authenticate_token.id}))
        render :json => {
          status: :updated, id: @question.id}
      else
        render :json => {
          errors: @question.errors,
          status: :unprocessable_entity}
      end
    else
      render :json => {
        error: "invalid authentication token",
      }
    end
  end

  def destroy
    if authenticate_token && authenticate_token.id == @question.user_id
      @question.destroy
      render :json => {
        status: :destroyed}
    else
      render :json => {
        error: "invalid authentication token",
      }
    end
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

end

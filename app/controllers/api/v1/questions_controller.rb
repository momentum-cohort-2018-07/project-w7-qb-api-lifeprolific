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

  private

  def set_question
    @question = Question.find(params[:id])
  end

end

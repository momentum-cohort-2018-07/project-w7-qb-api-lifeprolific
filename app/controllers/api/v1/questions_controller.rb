class Api::V1::QuestionsController < ApplicationController

  def index
    @questions = Question.page(params[:page]).per(10)
  end

end

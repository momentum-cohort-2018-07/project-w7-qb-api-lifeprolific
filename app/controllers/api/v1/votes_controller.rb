class Api::V1::VotesController < ApplicationController

  def create
    if authenticate_token
      @vote = Vote.find_by user_id: authenticate_token.id, answer_id: params[:answer_id]
      if @vote
        if @vote.update(params.permit(:value, :answer_id).merge({user_id: authenticate_token.id}))
          render :json => {
            status: :updated, id: @vote.id}
        else
          render :json => {
            errors: @vote.errors,
            status: :unprocessable_entity}
        end
      else
        @vote = Vote.new(params.permit(:value, :answer_id).merge({user_id: authenticate_token.id}))
        if @vote.save
          render :json => {
            status: :saved, id: @vote.id}
        else
          render :json => {
            errors: @vote.errors,
            status: :unprocessable_entity}
        end
      end
    else
      render :json => {
        error: "invalid authentication token",
      }
    end
  end

  def destroy

  end

end

class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(answer_params)

    respond_to do |format|
      if @answer.save
        vote = Vote.new(value: 0, user_id: @answer.user_id, answer_id: @answer.id)
        vote.save
        UserMailer.with(user: @answer.question.user, url: question_url(@answer.question, anchor:'answer_' + @answer.id.to_s)).alert_email.deliver_now
        format.html {redirect_to @answer.question, notice: 'Answer was successfully created.'}
        format.json {render :show, status: :created, location: @answer}
      else
        format.html {redirect_to @answer.question}
        format.json {render json: @answer.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    respond_to do |format|
      if (answer_params[:question_accepted_id] != nil && Answer.exists?(question_accepted_id: answer_params[:question_accepted_id]))
          format.html { redirect_to @answer.question }
      else
        if @answer.update({question_accepted_id:nil}.merge(answer_params))
          format.html {redirect_to @answer.question, notice: 'Answer was successfully updated.' }
          format.json {render :show, status: :ok, location: @answer }
        else
          format.html { redirect_to @answer.question }
          format.json { render json: @answer.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html {redirect_to @question, notice: 'Answer was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private


  # Use callbacks to share common setup or constraints between actions.
  def set_answer
    @answer = Answer.find(params[:id])
    @question = @answer.question
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def answer_params
    params.permit(:body, :user_id, :question_id, :question_accepted_id)
  end
end

class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:destroy, :edit]
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  
  respond_to :html
  
  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.new
    respond_with(@answer)
  end
  
  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    if @answer.description.length <20 
      flash[:alert] = "Answer length needs at least 20 characters!"
    else
      @answer.question_id = @question.id
      @answer.user_id = current_user.id
      @answer.save
    end
    redirect_to @question
  end

  def destroy
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])

  if @answer.delete
    # flash[:notice] = "Answer removed"
    redirect_to @question
  else
    redirect_to @question
    flash[:notice] = "There was an error deleting your answer, try again"
  end
  end
  
  def answer_params
    params.require(:answer).permit(:description,:vote, :user_id)
  end

  def index
    @answers = Answer.all
    respond_with(@answers)
  end

  def show
    respond_with(@answer)
  end

  def update
    @answer.update(answer_params)
    respond_with(@answer)
  end

  private
    def set_answer
      @answer = Answer.find(params[:id])
    end

    def answer_params
      params.require(:answer).permit(:question_id, :title, :description)
    end

end

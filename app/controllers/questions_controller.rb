class QuestionsController < ApplicationController
  before_action :set_questionable
  before_action :set_question, only: %i[edit update destroy]

  def create
    @question = @questionable.questions.new(question_params)
    if @question.save
      redirect_to @questionable, notice: "Question was successfully created."
    else
      redirect_to @questionable, error: "Question was successfully created."
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @questionable, notice: "Question was successfully updated."
    else
      redirect_to @questionable, error: "Question was successfully updated."
    end
  end

  def destroy
    if @question.destroy
      redirect_to @questionable, notice: "Question was successfully destroyed."
    else
      redirect_to @questionable, error: "Question was successfully destroyed."
    end
  end

  private

  def question_params
    params.require(:question).permit(:body)
  end

  def set_question
    @question ||= @questionable.questions.find(params[:id])
  end

  def set_questionable
    @questionable ||=
      if params[:skill_level_item_id]
        SkillLevelItem.find(params[:skill_level_item_id])
      end
  end
end


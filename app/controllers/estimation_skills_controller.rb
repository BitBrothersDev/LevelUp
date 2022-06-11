class EstimationSkillsController < ApplicationController
  before_action :set_estimation_skill, only: %i[ show edit update destroy ]
  before_action :find_skill, only: %i[ create ]
  # GET /estimation_skills or /estimation_skills.json
  def index
    @estimation_skills = EstimationSkill.all
  end

  # GET /estimation_skills/1 or /estimation_skills/1.json
  def show
  end

  # GET /estimation_skills/new
  def new
    @estimation_skill = EstimationSkill.new
  end

  # GET /estimation_skills/1/edit
  def edit
  end

  # POST /estimation_skills or /estimation_skills.json
  def create
    @estimation_skill = @skill.estimation_skills.find_by_user_id(current_user.id)
    if @estimation_skill
      @estimation_skill.update!(level: params[:estimation])
    else
      @estimation_skill =  @skill.estimation_skills.create(level: params[:estimation], user: current_user)
    end

    # @estimation_skill = EstimationSkill.new(estimation_skill_params)

    respond_to do |format|
      if @estimation_skill.persisted?
        # format.json { render json: { message: 'message', status: :created } }
        format.json { render(partial: "skills/skill_estimation", locals: {skill: @skill}) }
      else
        # format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @estimation_skill.errors, status: :unprocessable_entity } }
      end
    end
  end

  # PATCH/PUT /estimation_skills/1 or /estimation_skills/1.json
  def update
    respond_to do |format|
      if @estimation_skill.update(estimation_skill_params)
        format.html { redirect_to estimation_skill_url(@estimation_skill), notice: "Estimation skill was successfully updated." }
        format.json { render :show, status: :ok, location: @estimation_skill }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @estimation_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /estimation_skills/1 or /estimation_skills/1.json
  def destroy
    @estimation_skill.destroy

    respond_to do |format|
      format.html { redirect_to estimation_skills_url, notice: "Estimation skill was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def find_skill
    @skill = Skill.find(params[:skill_id])
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_estimation_skill
      @estimation_skill = EstimationSkill.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def estimation_skill_params
      params.require(:estimation_skill).permit(:level, :user_id, :skill_id)
    end
end

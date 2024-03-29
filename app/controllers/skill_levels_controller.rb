class SkillLevelsController < ApplicationController
  before_action :set_skill_level, only: %i[ show edit update destroy ]

  # GET /skill_levels or /skill_levels.json
  def index
    @skill_levels = SkillLevel.all
  end

  # GET /skill_levels/1 or /skill_levels/1.json
  def show
  end

  # GET /skill_levels/new
  def new
    @skill_level = SkillLevel.new
  end

  # GET /skill_levels/1/edit
  def edit
  end

  # POST /skill_levels or /skill_levels.json
  def create
    @skill_level = SkillLevel.new(skill_level_params)

    respond_to do |format|
      if @skill_level.save
        format.html { redirect_to skill_level_url(@skill_level), notice: "Skill level was successfully created." }
        format.json { render :show, status: :created, location: @skill_level }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @skill_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /skill_levels/1 or /skill_levels/1.json
  def update
    respond_to do |format|
      if @skill_level.update(skill_level_params)
        format.html { redirect_back(fallback_location: @skill_level.skill, notice: "Skill level was successfully updated.") }
        format.json { render :show, status: :ok, location: @skill_level.skill }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @skill_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /skill_levels/1 or /skill_levels/1.json
  def destroy
    @skill_level.destroy

    respond_to do |format|
      format.html { redirect_to skill_levels_url, notice: "Skill level was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill_level
      @skill_level = SkillLevel.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def skill_level_params
      params.require(:skill_level).permit(:skill_id, :level_id, :notice)
    end
end

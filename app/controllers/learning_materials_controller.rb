class LearningMaterialsController < ApplicationController
  before_action :set_learning_material, only: %i[ show edit update destroy ]
  before_action :find_learnable, only: %i[ create update destroy ]

  # GET /learning_materials or /learning_materials.json
  def index
    @learning_materials = LearningMaterial.all
  end

  # GET /learning_materials/1 or /learning_materials/1.json
  def show
  end

  # GET /learning_materials/new
  def new
    @learning_material = LearningMaterial.new
  end

  # GET /learning_materials/1/edit
  def edit
  end

  # POST /learning_materials or /learning_materials.json
  def create
    @learning_material = @skill_level.learning_materials.new(learning_material_params)

    respond_to do |format|
      if @learning_material.save
        format.html { redirect_to @skill_level.skill, notice: "Learning material was successfully created." }
        format.json { render :show, status: :created, location: @skill_level.skill }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @learning_material.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /learning_materials/1 or /learning_materials/1.json
  def update
    respond_to do |format|
      if @learning_material.update(learning_material_params)
        format.html { redirect_to learning_material_url(@learning_material), notice: "Learning material was successfully updated." }
        format.json { render :show, status: :ok, location: @learning_material }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @learning_material.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /learning_materials/1 or /learning_materials/1.json
  def destroy
    @learning_material.destroy

    respond_to do |format|
      format.html { redirect_to learning_materials_url, notice: "Learning material was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def find_learnable
      @skill_level = SkillLevel.find_by_id(params[:skill_level_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_learning_material
      @learning_material = LearningMaterial.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def learning_material_params
      params.require(:learning_material).permit(:material_type, :name, :link, :learnable_id, :learnable_id)
    end
end

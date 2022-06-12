class EstimationSkillLevelItemsController < ApplicationController
  before_action :set_estimation_skill_level_item, only: %i[ show edit update destroy ]
  before_action :find_skill_level_item, only: %i[ create ]
  # GET /estimation_skill_level_items or /estimation_skill_level_items.json
  def index
    @estimation_skill_level_items = EstimationSkillLevelItem.all
  end

  # GET /estimation_skill_level_items/1 or /estimation_skill_level_items/1.json
  def show
  end

  # GET /estimation_skill_level_items/new
  def new
    @estimation_skill_level_item = EstimationSkillLevelItem.new
  end

  # GET /estimation_skill_level_items/1/edit
  def edit
  end

  # POST /estimation_skill_level_items or /estimation_skill_level_items.json
  def create
    @estimation_skill_level_item = @skill_level_item.estimation_skill_level_items.find_by_user_id(current_user.id)
    if @estimation_skill_level_item
      @estimation_skill_level_item.update!(level: params[:estimation])
    else
      @estimation_skill_level_item =  @skill_level_item.estimation_skill_level_items.create(level: params[:estimation], user: current_user)
    end

    # @estimation_skill = EstimationSkill.new(estimation_skill_params)

    respond_to do |format|
      if @estimation_skill_level_item.persisted?
        # format.json { render json: { message: 'message', status: :created } }
        format.json { render(partial: "skills/estimation_skill_level_item", locals: {skill_level_item: @skill_level_item}) }
      else
        # format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @estimation_skill_level_item.errors, status: :unprocessable_entity } }
      end
    end
  end

  # PATCH/PUT /estimation_skill_level_items/1 or /estimation_skill_level_items/1.json
  def update
    respond_to do |format|
      if @estimation_skill_level_item.update(estimation_skill_level_item_params)
        format.html { redirect_to estimation_skill_level_item_url(@estimation_skill_level_item), notice: "Estimation skill level item was successfully updated." }
        format.json { render :show, status: :ok, location: @estimation_skill_level_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @estimation_skill_level_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /estimation_skill_level_items/1 or /estimation_skill_level_items/1.json
  def destroy
    @estimation_skill_level_item.destroy

    respond_to do |format|
      format.html { redirect_to estimation_skill_level_items_url, notice: "Estimation skill level item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def find_skill_level_item
    @skill_level_item = SkillLevelItem.find(params[:skill_level_item_id])
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_estimation_skill_level_item
      @estimation_skill_level_item = EstimationSkillLevelItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def estimation_skill_level_item_params
      params.require(:estimation_skill_level_item).permit(:level, :user_id, :skill_id)
    end
end

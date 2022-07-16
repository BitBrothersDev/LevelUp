class SkillLevelItemsController < ApplicationController
  before_action :set_skill_level_item, only: %i[ show edit update destroy ]
  before_action :find_skill_level, only: %i[ create update destroy ]

  # GET /skill_level_items or /skill_level_items.json
  def index
    @skill_level_items = SkillLevelItem.all
  end

  # GET /skill_level_items/1 or /skill_level_items/1.json
  def show
  end

  # GET /skill_level_items/new
  def new
    @skill_level_item = SkillLevelItem.new
  end

  # GET /skill_level_items/1/edit
  def edit
  end

  # POST /skill_level_items or /skill_level_items.json
  def create
    # binding.pry
    @skill_level_item = @skill_level.skill_level_items.new(skill_level_item_params)
    # items = params[:items_data].gsub("\n", "").gsub(";", "").split("•")
    # @skill_level.update(notice: items.first)
    # items.shift
    # items_array = items.reject(&:blank?).map { |e| e.gsub(/^./, "")}
    # items_array.each do |item|
    #   @skill_level.skill_level_items.find_or_create_by(name: item)
    # end
    respond_to do |format|
      if @skill_level_item.save
        format.html { redirect_to @skill_level.skill, notice: "Skill level item was successfully created." }
        format.json { render :show, status: :created, location: @skill_level.skill }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @skill_level_item.errors, status: :unprocessable_entity }
      end
    end
    # respond_to do |format|
    #   format.html { redirect_to @skill_level.skill, notice: "Skill level item was successfully created." }
    #   format.json { render :show, status: :created, location: @skill_level.skill }
    # end
  end

  # PATCH/PUT /skill_level_items/1 or /skill_level_items/1.json
  def update
    respond_to do |format|
      if @skill_level_item.update(skill_level_item_params)
        format.html { redirect_to @skill_level.skill, notice: "Skill level item was successfully updated." }
        format.json { render :show, status: :ok, location: @skill_level.skill }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @skill_level_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /skill_level_items/1 or /skill_level_items/1.json
  def destroy
    @skill_level_item.destroy

    respond_to do |format|
      format.html { redirect_to skill_level_items_url, notice: "Skill level item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def find_skill_level
      @skill_level = SkillLevel.find(params[:skill_level_id])
    end

    def set_skill_level_item
      @skill_level_item = SkillLevelItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def skill_level_item_params
      params.require(:skill_level_item).permit(:name, :tip, :skill_level_id)
    end
end

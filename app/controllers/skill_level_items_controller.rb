class SkillLevelItemsController < ApplicationController
  before_action :set_skill_level_item, only: %i[ show edit update destroy ]
  before_action :find_skill_level, only: %i[ create destroy ]

  DEFAULT_ITEMS_COUNT = 15

  # GET /skill_level_items or /skill_level_items.json
  def index
    level_title_params = params[:level_title]
    level = Level.find_by_title(level_title_params)
    @skill_level_items = fetch_skill_level_items(level_title_params, level)
  end

  # GET /skill_level_items/1 or /skill_level_items/1.json
  def show
  end

  def random_skill_level_item
    level_title_params = params[:level_title]
    level = Level.find_by_title(level_title_params)
    materials = params[:materials]
    explanation = params[:explanation]
    @skills = level ? Skill.by_level(level) : Skill.for_random_page
    skill = Skill.find_by_name(params[:skill_name])
    @skill_level_items = fetch_skill_level_items_rand(materials, level, explanation, skill)
    @skill_level_item = @skill_level_items.sample
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
        format.html { redirect_to @skill_level_item, notice: "Skill level item was successfully updated." }
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

  def fetch_skill_level_items_rand(materials, level, explanation = nil, skill)
    skill_level_items =  SkillLevel.fetch_skill_level_items(level) if level
    skill_level_items ||= SkillLevelItem.all
    items = if materials == 'Without Materials'
      skill_level_items.without_material
    elsif materials == 'With Materials'
      skill_level_items.with_material
    else
      skill_level_items.materials
            end
    items = items.with_own_explanation if explanation.presence == 'With explanation'
    items = items.without_own_explanation if explanation.presence == 'Without explanation'
    items = items.where(skill_level: skill.skill_levels) if skill

    # Eager load all associations to prevent N+1 queries
    # Random page has same rendering as index page
    items.includes(
      :questions,
      :rich_text_own_explanation,
      :skill_level,
      {
        skill: :skill_levels,  # For estimation component
        learning_materials: :complete_material  # Direct association from skill_level_item
      }
    ).compact
  end

  def fetch_skill_level_items(level_title, level)
    base_query = if level
      SkillLevel.fetch_skill_level_items(level)
    elsif level_title == 'Without Materials'
      SkillLevelItem.without_material
    else
      SkillLevelItem.materials
    end

    # Eager load associations to prevent N+1 queries
    # Based on Bullet gem analysis:
    # ALL collapsed sections are rendered on page load (just hidden with CSS)
    # Load learning_materials DIRECTLY from skill_level_item, not through skill_level
    base_query
      .includes(
        :rich_text_own_explanation,
        :skill_level,
        {
          skill: :skill_levels,  # For estimation component
          learning_materials: :complete_material  # Direct association from skill_level_item
        }
      )
      .page(params[:page])
      .per(DEFAULT_ITEMS_COUNT)
  end
  # Use callbacks to share common setup or constraints between actions.
  def find_skill_level
    @skill_level = SkillLevel.find(params[:skill_level_id])
  end

  def set_skill_level_item
    @skill_level_item = SkillLevelItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def skill_level_item_params
    params.require(:skill_level_item).permit(:name, :tip, :skill_level_id, :own_explanation)
  end
end

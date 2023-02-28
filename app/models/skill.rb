class Skill < ApplicationRecord
  has_many :skill_levels, :dependent => :delete_all
  has_many :levels, through: :skill_levels
  has_many :skill_level_items, through: :skill_levels
  has_many :estimation_skills
  belongs_to :skill_category

  scope :group_for_show, -> do
    a = all.order("created_at ASC").group_by do |skill|
      skill.skill_category&.parent_category&.name
    end
    a.map do |parent_skill, skill_array|
      arr = skill_array.group_by do |skill_from_array|
        skill_from_array.skill_category&.name
      end
      {"#{parent_skill}": arr}
    end
  end

  scope :by_level, ->(level) do
    find_by_sql(
      "
        SELECT skills.name, COUNT(DISTINCT(skill_level_items.id)) as skill_level_count FROM skills
        INNER JOIN skill_levels on skill_levels.skill_id = skills.id
        INNER JOIN skill_level_items on skill_level_items.skill_level_id  = skill_levels.id
        WHERE skills.crucial = true and skill_levels.id in (#{level.skill_level_ids.join(', ')})
        GROUP BY (skills.id)
      "
    )
  end

  scope :for_random_page, -> do
    find_by_sql(
      "
        SELECT skills.name, COUNT(DISTINCT(skill_level_items.id)) as skill_level_count FROM skills
        INNER JOIN skill_levels on skill_levels.skill_id  = skills.id
        INNER JOIN skill_level_items on skill_level_items.skill_level_id = skill_levels.id
        WHERE skills.crucial = true
        GROUP BY skills.id
      "
    )
  end
end

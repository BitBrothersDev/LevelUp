class Skill < ApplicationRecord
  has_many :skill_levels
  has_many :levels, through: :skill_levels
  belongs_to :skill_category

  scope :group_for_show, -> do
    a = all.group_by do |skill|
      skill.skill_category&.parent_category&.name
    end
    a.map do |parent_skill, skill_array|
      arr = skill_array.group_by do |skill_from_array|
        skill_from_array.skill_category&.name
      end
      {"#{parent_skill}": arr}
    end
  end
end

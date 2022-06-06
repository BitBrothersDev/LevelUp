class SkillLevelItem < ApplicationRecord
  belongs_to :skill_level
  has_many :learning_materials

  scope :fetch_for_current_skill, ->(skill_level_id) { where(skill_level_id: skill_level_id) }
end

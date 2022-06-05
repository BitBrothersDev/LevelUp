class SkillLevelItem < ApplicationRecord
  belongs_to :skill_level
  has_many :learning_materials

  scope :fetch_for_current_skill, ->(skill_id) { joins(:skill_level).where(skill_levels: { skill_id: skill_id }) }
end

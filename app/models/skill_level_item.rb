class SkillLevelItem < ApplicationRecord
  belongs_to :skill_level
  has_one :skill, through: :skill_level
  has_many :learning_materials
  has_many :estimation_skill_level_items

  scope :materials, -> { order('learning_materials_count ASC') }
  scope :fetch_for_current_skill, ->(skill_level_id) { where(skill_level_id: skill_level_id) }
end
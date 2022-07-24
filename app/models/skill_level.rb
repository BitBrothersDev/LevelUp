class SkillLevel < ApplicationRecord
  belongs_to :skill
  belongs_to :level
  has_many :learning_materials, as: :learnable
  has_many :skill_level_items
  has_rich_text :notice

  scope :fetch_skill_level_items, ->(level) { SkillLevelItem.where(skill_level: where(level: level)).materials }

  def skill_level_items_by_ids(ids)

  end
end

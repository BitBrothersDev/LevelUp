class SkillLevelItem < ApplicationRecord
  belongs_to :skill_level
  has_one :skill, through: :skill_level
  has_many :learning_materials
  has_many :estimation_skill_level_items
  has_many :questions, as: :questionable

  has_rich_text :own_explanation
  scope :materials, -> { all.order(learning_materials_count: :desc) }
  scope :without_material, -> { where('learning_materials_count < 1') }
  scope :with_material, -> { where('learning_materials_count >= 1') }
  scope :with_own_explanation, -> do
    record_ids = ActionText::RichText.where(record_id: self.pluck(:id),
                                            name: 'own_explanation',
                                            record_type: "SkillLevelItem")
                                     .where.not(id: nil).pluck(:record_id)
    where(id: record_ids)
  end
  scope :without_own_explanation, -> do
    record_ids = ActionText::RichText.where(record_id: self.pluck(:id),
                                            name: 'own_explanation',
                                            record_type: "SkillLevelItem")
                                     .where.not(id: nil).pluck(:record_id)
    where.not(id: record_ids)
  end
  scope :fetch_for_current_skill, ->(skill_level_id) { where(skill_level_id: skill_level_id) }
end

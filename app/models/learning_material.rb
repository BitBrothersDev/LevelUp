class LearningMaterial < ApplicationRecord
  belongs_to :learnable, polymorphic: true
  belongs_to :skill_level_item, optional: true, counter_cache: true
  has_one :complete_material

  enum material_type: %w[Article Book Community Competency Course Program Training Video Other]
end

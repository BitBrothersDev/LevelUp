class LearningMaterial < ApplicationRecord
  belongs_to :learnable, polymorphic: true

  enum material_type: %w[Article Book Community Competency Course Program Training Video Other]
end

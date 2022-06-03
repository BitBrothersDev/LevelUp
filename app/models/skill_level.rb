class SkillLevel < ApplicationRecord
  belongs_to :skill
  belongs_to :level
  has_many :learning_materials, as: :learnable
end

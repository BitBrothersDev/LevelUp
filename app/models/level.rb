class Level < ApplicationRecord
  has_many :skill_levels
  has_many :skills, through: :skill_levels
end

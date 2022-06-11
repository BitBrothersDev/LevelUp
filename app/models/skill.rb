class Skill < ApplicationRecord
  has_many :skill_levels, :dependent => :delete_all
  has_many :levels, through: :skill_levels
  has_many :estimation_skills
  belongs_to :skill_category

  scope :group_for_show, -> do
    a = all.order("created_at ASC").group_by do |skill|
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

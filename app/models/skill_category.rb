class SkillCategory < ApplicationRecord
  has_many :children, class_name: 'SkillCategory', foreign_key: :parent_category_id
  belongs_to :parent_category, class_name: 'SkillCategory', foreign_key: :parent_category_id, optional: true
  # belongs_to :daughter_category, class_name: 'SkillCategory', foreign_key: :daughter_category_id, optional: true
  has_many :skills
end

class RemoveDaughterIdFromSkillCategories < ActiveRecord::Migration[7.0]
  def change
    remove_column :skill_categories, :daughter_category_id
  end
end

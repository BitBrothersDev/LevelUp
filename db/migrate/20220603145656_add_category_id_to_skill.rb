class AddCategoryIdToSkill < ActiveRecord::Migration[7.0]
  def change
    add_reference :skills, :skill_category
  end
end

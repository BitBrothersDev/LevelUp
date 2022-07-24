class AddLearningMaterialsCountToSkillLevelItems < ActiveRecord::Migration[7.0]
  def change
    add_column :skill_level_items, :learning_materials_count, :integer, default: 0
  end
end

class AddSkillLevelItemToLearningMaterials < ActiveRecord::Migration[7.0]
  def change
    add_reference :learning_materials, :skill_level_item
  end
end

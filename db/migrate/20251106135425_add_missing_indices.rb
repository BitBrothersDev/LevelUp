class AddMissingIndices < ActiveRecord::Migration[7.0]
  def change
    # CompleteMaterials - used frequently with learning_material_id lookups
    add_index :complete_materials, :learning_material_id unless index_exists?(:complete_materials, :learning_material_id)

    # LearningMaterials - composite index for polymorphic + skill_level_item queries
    unless index_exists?(:learning_materials, [:learnable_type, :learnable_id, :skill_level_item_id], name: 'index_learning_materials_on_learnable_and_item')
      add_index :learning_materials, [:learnable_type, :learnable_id, :skill_level_item_id],
                name: 'index_learning_materials_on_learnable_and_item'
    end

    # SkillLevelItems - foreign key index
    add_index :skill_level_items, :skill_level_id unless index_exists?(:skill_level_items, :skill_level_id)

    # EstimationSkillLevelItems - composite index for lookups by skill_level_item + user
    unless index_exists?(:estimation_skill_level_items, [:skill_level_item_id, :user_id], name: 'index_estimation_on_item_and_user')
      add_index :estimation_skill_level_items, [:skill_level_item_id, :user_id],
                name: 'index_estimation_on_item_and_user'
    end

    # SkillLevels - foreign keys
    add_index :skill_levels, :skill_id unless index_exists?(:skill_levels, :skill_id)
    add_index :skill_levels, :level_id unless index_exists?(:skill_levels, :level_id)

    # LearningMaterials - add index on skill_level_item_id for the has_many relationship
    add_index :learning_materials, :skill_level_item_id unless index_exists?(:learning_materials, :skill_level_item_id)
  end
end

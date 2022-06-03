class CreateLearningMaterials < ActiveRecord::Migration[7.0]
  def change
    create_table :learning_materials do |t|
      t.integer :material_type
      t.string :name
      t.string :link
      t.integer :learnable_id
      t.string :learnable_type

      t.timestamps
    end
  end
end

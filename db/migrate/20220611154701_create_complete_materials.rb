class CreateCompleteMaterials < ActiveRecord::Migration[7.0]
  def change
    create_table :complete_materials do |t|
      t.references :user, null: false, foreign_key: true
      t.references :learning_material, null: false, foreign_key: true
      t.boolean :is_completed

      t.timestamps
    end
  end
end

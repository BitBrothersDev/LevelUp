class CreateMaterialContainers < ActiveRecord::Migration[7.0]
  def change
    create_table :material_containers do |t|
      t.belongs_to :job_function, null: false, foreign_key: true
      t.belongs_to :level, null: false, foreign_key: true

      t.timestamps
    end
  end
end

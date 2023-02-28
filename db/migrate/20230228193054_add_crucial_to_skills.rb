class AddCrucialToSkills < ActiveRecord::Migration[7.0]
  def change
    add_column :skills, :crucial, :boolean, default: false
    add_index :skills, :crucial
  end
end

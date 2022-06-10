class ChangeFieldType < ActiveRecord::Migration[7.0]
  def change
    change_column :skill_level_items, :name, :text
  end
end

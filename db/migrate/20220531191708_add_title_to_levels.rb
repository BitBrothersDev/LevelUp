class AddTitleToLevels < ActiveRecord::Migration[7.0]
  def change
    add_column :levels, :title, :string
  end
end

class ChangeDescriptionColumnTypeInSkills < ActiveRecord::Migration[7.0]
  def change
    change_column :skills, :description, :text
  end
end

class CreateSkillLevelItems < ActiveRecord::Migration[7.0]
  def change
    create_table :skill_level_items do |t|
      t.string :name
      t.string :tip
      t.belongs_to :skill_level, null: false, foreign_key: true

      t.timestamps
    end
  end
end

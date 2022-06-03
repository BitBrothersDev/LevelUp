class CreateSkillLevels < ActiveRecord::Migration[7.0]
  def change
    create_table :skill_levels do |t|
      t.belongs_to :skill, null: false, foreign_key: true
      t.belongs_to :level, null: false, foreign_key: true
      t.string :notice

      t.timestamps
    end
  end
end

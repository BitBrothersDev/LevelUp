class CreateEstimationSkillLevelItems < ActiveRecord::Migration[7.0]
  def change
    create_table :estimation_skill_level_items do |t|
      t.float :level
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :skill_level_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end

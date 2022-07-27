class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.text :body
      t.references :questionable, polymorphic: true, null: false

      t.timestamps
    end
  end
end

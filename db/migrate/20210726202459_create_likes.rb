class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :idea, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end

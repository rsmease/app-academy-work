class CreateSubreddits < ActiveRecord::Migration[5.1]
  def change
    create_table :subreddits do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :moderator_id, null: false
      t.timestamps
    end
    add_index :subreddits, :moderator_id
  end
end

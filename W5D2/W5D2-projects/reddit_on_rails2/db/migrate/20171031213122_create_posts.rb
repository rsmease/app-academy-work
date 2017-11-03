class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.text :content
      t.integer :sub_id
      t.integer :author_id
      t.timestamps
    end
    add_index :posts, :sub_id
    add_index :posts, :author_id
  end
end

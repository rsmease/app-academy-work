class MakePostUrlOptional < ActiveRecord::Migration[5.1]
  def change
    change_table :posts do |t|
      t.remove :url
    end
  end
end

class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :image
      t.string :content
      t.string :purview, dafault: "all"
      t.string :status
      t.integer :viewed_count, default: 0
      t.integer :replies_count, default: 0
      t.integer :user_id
      t.datetime :last_replied_at
      t.timestamps
    end
  end
end

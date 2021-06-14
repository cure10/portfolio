class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer "user_id"
      t.string "title"
      t.string "title_image_id"
      t.text "title_comment"


      t.timestamps
    end
  end
end

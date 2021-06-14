class RemoveBookIdFromFavorite < ActiveRecord::Migration[5.2]
  def change
    remove_column :favorites, :book_id, :integer
  end
end

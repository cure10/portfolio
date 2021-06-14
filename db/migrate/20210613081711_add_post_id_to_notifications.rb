class AddPostIdToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :post_id, :integer
  end
end

class RemoveItemIdFromNotifications < ActiveRecord::Migration[5.2]
  def change
    remove_column :notifications, :item_id, :integer
  end
end

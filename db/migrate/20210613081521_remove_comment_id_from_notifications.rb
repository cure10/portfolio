class RemoveCommentIdFromNotifications < ActiveRecord::Migration[5.2]
  def change
    remove_column :notifications, :comment_id, :integer
  end
end

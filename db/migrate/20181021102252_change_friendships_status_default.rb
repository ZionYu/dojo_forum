class ChangeFriendshipsStatusDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:friendships, :status, 'pending')
  end
end

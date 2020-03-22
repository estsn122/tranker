class RenameUnregisteredUsersToFollowedUsers < ActiveRecord::Migration[5.2]
  def change
    rename_table :unregistered_users, :followed_users
  end
end

class AddUserIdToLeague < ActiveRecord::Migration[6.1]
  def change
    add_column :leagues, :user_id, :uuid
    add_foreign_key :leagues, :users
  end
end

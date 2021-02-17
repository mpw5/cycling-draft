class AddUserIdToTeams < ActiveRecord::Migration[6.1]
  def change
    add_column :teams, :user_id, :uuid
    add_foreign_key :teams, :users
  end
end

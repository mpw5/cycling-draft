class AddCurrentDraftPositionToLeague < ActiveRecord::Migration[6.1]
  def change
    add_column :leagues, :current_draft_position, :integer, null: false, default: 1
  end
end

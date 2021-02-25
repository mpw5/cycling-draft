class AddDraftPositionToTeam < ActiveRecord::Migration[6.1]
  def change
    add_column :teams, :draft_position, :integer, null: true
    add_index :teams, %i[league_id draft_position], unique: true
  end
end

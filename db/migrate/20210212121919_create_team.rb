class CreateTeam < ActiveRecord::Migration[6.1]
  def change
    create_table :teams, id: :uuid do |t|
      t.text :name
      t.references :league, type: :uuid, null: false, foreign_key: true
      t.timestamps
    end
    add_index :teams, %i[league_id name], unique: true
  end
end

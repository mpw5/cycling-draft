class CreateRiderTeamLeagues < ActiveRecord::Migration[6.1]
  def change
    create_table :rider_team_leagues, id: :uuid do |t|
      t.uuid :rider_id
      t.uuid :team_id
      t.uuid :league_id

      t.timestamps
    end
  end
end

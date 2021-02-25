require 'rails_helper'

RSpec.describe 'league', type: :model do
  describe '#start_draft!' do
    let!(:league) { create :league, aasm_state: :pre_draft }
    let!(:teams) { create_list :team, 3, league: league }
    it 'allocates each team in the league a unique draft position' do
      league.start_draft!
      expect(teams[0].reload.draft_position).to be_between(1, teams.size)
      expect(teams[1].reload.draft_position).to be_between(1, teams.size)
      expect(teams[2].reload.draft_position).to be_between(1, teams.size)
      expect(Team.where(draft_position: 1).count).to eq 1
      expect(Team.where(draft_position: 2).count).to eq 1
      expect(Team.where(draft_position: 3).count).to eq 1
    end
  end
end

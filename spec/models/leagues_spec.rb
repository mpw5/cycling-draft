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

  describe '#update_draft_position' do
    let!(:league) { create :league, aasm_state: :drafting, draft_forward: true, current_draft_position: 1 }
    let!(:team1) { create :team, name: 'team1', league: league, draft_position: 1 }
    let!(:team2) { create :team, name: 'team2', league: league, draft_position: 2 }
    let!(:team3) { create :team, name: 'team3', league: league, draft_position: 3 }

    context 'drafting forwards' do
      context 'first pick' do
        it 'increases the draft position by 1' do
          league.update_draft_position
          expect(league.current_draft_position).to eq 2
        end
      end

      context 'mid-round pick' do
        before { league.current_draft_position = 2 }
        it 'increases the draft position by 1' do
          league.update_draft_position
          expect(league.current_draft_position).to eq 3
        end
      end

      context 'last pick' do
        before { league.current_draft_position = 3 }
        it 'does not change the draft position' do
          league.update_draft_position
          expect(league.current_draft_position).to eq 3
        end

        it 'reverses the direction of the draft' do
          league.update_draft_position
          expect(league.draft_forward?).to eq false
        end
      end
    end

    context 'drafting backwards' do
      before(:each) { league.draft_forward = false }

      context 'first pick' do
        before { league.current_draft_position = 1 }
        it 'does not change the draft position' do
          league.update_draft_position
          expect(league.current_draft_position).to eq 1
        end

        it 'reverses the direction of the draft' do
          league.update_draft_position
          expect(league.draft_forward?).to eq true
        end
      end

      context 'mid-round pick' do
        before { league.current_draft_position = 2 }
        before { league.draft_forward = false }

        it 'decreases the draft position by 1' do
          league.update_draft_position
          expect(league.current_draft_position).to eq 1
        end
      end

      context 'last pick' do
        before { league.current_draft_position = 3 }
        it 'decreases the draft position by 1' do
          league.update_draft_position
          expect(league.current_draft_position).to eq 2
        end
      end
    end
  end
end

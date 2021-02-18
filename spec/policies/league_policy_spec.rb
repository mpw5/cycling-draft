require 'rails_helper'

RSpec.describe LeaguePolicy do
  subject { LeaguePolicy.new(user, league) }

  context 'user who did not create the league' do
    let(:league) { create(:league) }
    let(:user) { create(:user) }

    it 'allows the user to view and create leagues but not update or delete' do
      expect(subject).to permit(:index)
      expect(subject).to permit(:show)
      expect(subject).to permit(:new)
      expect(subject).to permit(:create)
      expect(subject).not_to permit(:destroy)
      expect(subject).not_to permit(:update)
      expect(subject).not_to permit(:edit)
    end
  end

  context 'user who created the league' do
    let(:user) { create :user }

    context 'pre-draft' do
      let(:league) { create(:league, aasm_state: :pre_draft, user: user) }

      it 'allows a user carry out all actions' do
        expect(subject).to permit(:index)
        expect(subject).to permit(:show)
        expect(subject).to permit(:new)
        expect(subject).to permit(:create)
        expect(subject).to permit(:destroy)
        expect(subject).to permit(:update)
        expect(subject).to permit(:edit)
      end
    end

    context 'drafting' do
      let(:league) { create(:league, aasm_state: :drafting, user: user) }

      it 'allows a user carry out all actions' do
        expect(subject).to permit(:index)
        expect(subject).to permit(:show)
        expect(subject).to permit(:new)
        expect(subject).to permit(:create)
        expect(subject).not_to permit(:destroy)
        expect(subject).not_to permit(:update)
        expect(subject).not_to permit(:edit)
      end
    end
  end

  context 'creating a team' do
    let(:league) { create(:league) }
    let(:user) { create(:user) }

    context 'user already has a team' do
      context 'in the league' do
        let!(:other_team) { create(:team, league: league, user: user) }

        it 'does not allow a team to be created' do
          expect(subject).not_to permit(:create_team)
        end
      end

      context 'in a different league' do
        let!(:other_league) { create(:league, aasm_state: :pre_draft, user: user) }
        let!(:other_team) { create(:team, league: other_league, user: user) }

        it 'allows a team to be created' do
          expect(subject).to permit(:create_team)
        end
      end
    end
  end
end

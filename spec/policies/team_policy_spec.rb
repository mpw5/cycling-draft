require 'rails_helper'

RSpec.describe TeamPolicy do
  subject { TeamPolicy.new(user, team) }

  context 'user who did not create the team' do
    let(:user) { create(:user) }
    let(:team_user) { create(:user) }
    let(:league) { create(:league, aasm_state: :pre_draft, user: user) }
    let(:team) { create(:team, league: league, user: team_user) }

    it 'allows the user to view teams but not create, update or delete' do
      expect(subject).to permit(:index)
      expect(subject).to permit(:show)
      expect(subject).not_to permit(:new)
      expect(subject).not_to permit(:create)
      expect(subject).not_to permit(:destroy)
      expect(subject).not_to permit(:update)
      expect(subject).not_to permit(:edit)
    end
  end

  context 'user who created the team' do
    let(:user) { create :user }

    context 'pre-draft' do
      let(:league) { create(:league, aasm_state: :pre_draft, user: user) }
      let(:team) { create(:team, league: league, user: user) }

      it 'allows a user to carry out all actions' do
        expect(subject).to permit(:index)
        expect(subject).to permit(:show)
        expect(subject).to permit(:new)
        expect(subject).to permit(:create)
        expect(subject).to permit(:destroy)
        expect(subject).not_to permit(:update)
        expect(subject).not_to permit(:edit)
      end
    end

    context 'drafting' do
      let(:league) { create(:league, aasm_state: :drafting, user: user) }
      let(:team) { create(:team, league: league, user: user) }

      it 'allows the user to view and create teams but not delete' do
        expect(subject).to permit(:index)
        expect(subject).to permit(:show)
        expect(subject).not_to permit(:new)
        expect(subject).not_to permit(:create)
      end

      it 'does not allow the user to create or delete a team' do
        expect(subject).not_to permit(:destroy)
      end

      context "when it is the team's turn to draft" do
        before do
          league.current_draft_position = 1
          team.draft_position = 1
        end
        it 'allows the team to be updated' do
          expect(subject).to permit(:update)
          expect(subject).to permit(:edit)
        end
      end

      context "when it is not the team's turn to draft" do
        it 'does not allow the team to be updated' do
          expect(subject).not_to permit(:update)
          expect(subject).not_to permit(:edit)
        end
      end
    end
  end
end

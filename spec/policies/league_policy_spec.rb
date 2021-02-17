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
end

module LeagueStateMachine
  extend ActiveSupport::Concern

  # rubocop:disable Metrics/BlockLength
  included do
    include AASM

    aasm column: 'aasm_state' do
      state :pre_draft, initial: true
      state :drafting
      state :post_draft

      event :draft_started do
        transitions from: :pre_draft, to: :drafting
      end

      event :draft_completed do
        transitions from: :drafting, to: :post_draft
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength

class League < ApplicationRecord
  include LeagueStateMachine

  validates :name, presence: true, uniqueness: true
  has_many :teams

  def pre_draft?
    aasm_state == 'pre_draft'
  end
end

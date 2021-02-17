class League < ApplicationRecord
  include LeagueStateMachine

  validates :name, presence: true, uniqueness: true
  has_many :teams, dependent: :destroy
  belongs_to :user

  def pre_draft?
    aasm_state.eql? 'pre_draft'
  end
end

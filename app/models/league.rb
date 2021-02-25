class League < ApplicationRecord
  include LeagueStateMachine

  validates :name, presence: true, uniqueness: true
  has_many :teams, dependent: :destroy
  belongs_to :user

  def pre_draft?
    aasm_state.eql? 'pre_draft'
  end

  def start_draft!
    randomize_draft_positions
    draft_started!
  end

  private

  def randomize_draft_positions
    teams.shuffle.each_with_index do |team, index|
      team.draft_position = index + 1
      team.save!
    end
  end
end

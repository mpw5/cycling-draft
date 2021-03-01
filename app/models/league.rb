class League < ApplicationRecord
  include LeagueStateMachine

  validates :name, presence: true, uniqueness: true
  has_many :rider_team_leagues, dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :riders, through: :rider_team_leagues
  belongs_to :user

  def pre_draft?
    aasm_state.eql? 'pre_draft'
  end

  def start_draft!
    randomize_draft_positions
    draft_started!
  end

  def available_riders
    Rider.all - riders
  end

  private

  def randomize_draft_positions
    teams.shuffle.each_with_index do |team, index|
      team.draft_position = index + 1
      team.save!
    end
  end
end

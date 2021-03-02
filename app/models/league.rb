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

  def update_draft_position
    move_forward and return if draft_forward?

    move_backward
  end

  def draft_forward?
    draft_forward
  end

  private

  def randomize_draft_positions
    teams.shuffle.each_with_index do |team, index|
      team.draft_position = index + 1
      team.save!
    end
  end

  def move_forward
    current_draft_position == teams.size ? reverse_direction : self.current_draft_position += 1
    save!
  end

  def move_backward
    current_draft_position == 1 ? reverse_direction : self.current_draft_position -= 1
    save!
  end

  def reverse_direction
    self.draft_forward = false if current_draft_position == teams.size

    self.draft_forward = true if current_draft_position == 1
  end
end

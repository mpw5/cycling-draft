class Team < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :league_id, message: 'has already been taken in this league' }
  validates :draft_position, uniqueness: { scope: :league_id, allow_blank: true, message: 'has already been taken in this league' }
  belongs_to :league
  belongs_to :user
end

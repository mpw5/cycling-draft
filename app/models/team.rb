class Team < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :league_id, message: 'has already been taken in this league' }
  belongs_to :league
  belongs_to :user
end

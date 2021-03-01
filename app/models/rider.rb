class Rider < ApplicationRecord
  has_many :rider_team_leagues, dependent: :destroy
  has_many :leagues, through: :rider_team_leagues
  has_many :teams, through: :rider_team_leagues
end

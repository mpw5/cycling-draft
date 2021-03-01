class RiderTeamLeague < ApplicationRecord
  belongs_to :rider
  belongs_to :league
  belongs_to :team
end

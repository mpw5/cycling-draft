class League < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true,
                       uniqueness: {
                         case_sensitive: false
                       }

  has_many :leagues, dependent: :destroy
  has_many :teams, dependent: :destroy
end

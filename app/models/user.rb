class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true,
                       uniqueness: {
                         case_sensitive: false
                       }
end

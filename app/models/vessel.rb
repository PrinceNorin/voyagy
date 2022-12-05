class Vessel < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :owner_id, presence: true
  validates :naccs, presence: true, uniqueness: true
end

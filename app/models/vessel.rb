class Vessel < ApplicationRecord
  belongs_to :user
  has_many :voyages, dependent: :destroy

  validates :name, presence: true
  validates :owner_id, presence: true
  validates :naccs, presence: true, uniqueness: true
end

class Voyage < ApplicationRecord
  belongs_to :vessel

  validates :from_loc, presence: true
  validates :to_loc, presence: true
  validates :departured_at, presence: true
  validates :arrived_at, presence: true
  validate :valid_departured_and_arrived_at

  private

  def valid_departured_and_arrived_at
    return unless departured_at && arrived_at
    return if departured_at < arrived_at
    self.errors.add(:departured_at, :invalid, message: 'must be less than arrived_at')
  end
end

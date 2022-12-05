require 'rails_helper'

RSpec.describe Voyage, type: :model do
  subject(:voyage) { FactoryBot.build(:voyage) }

  context 'departured_at validation' do
    it 'should be before arrived_at' do
      voyage.departured_at = 2.hours.from_now
      voyage.arrived_at = DateTime.current
      expect(voyage).not_to be_valid
      expect(voyage.errors[:departured_at]).not_to be_empty

      now = DateTime.current
      voyage.departured_at = now
      voyage.arrived_at = now
      expect(voyage).not_to be_valid
      expect(voyage.errors[:departured_at]).not_to be_empty

      voyage.departured_at = DateTime.current
      voyage.arrived_at = 2.hours.from_now
      expect(voyage).to be_valid
      expect(voyage.errors[:departured_at]).to be_empty
    end
  end
end

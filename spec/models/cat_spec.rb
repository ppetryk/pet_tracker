require 'rails_helper'

describe Cat, type: :model do
  let(:cat2) { build(:cat) }

  it 'creates valid object' do
    expect(cat2).to be_valid
  end

  context 'when pet type not correct' do
    let(:cat2) { build(:cat, pet_type: 'Elephant') }

    it 'creates object with errors' do
      expect(cat2).to_not be_valid
      expect(cat2.errors.messages[:pet_type]).to include "is not included in the list"
    end
  end

  context 'when tracker type not correct' do
    let(:cat2) { build(:cat, tracker_type: 'large') }

    it 'create object with errors' do
      expect(cat2).to_not be_valid
      expect(cat2.errors.messages[:tracker_type]).to include "is not included in the list"
    end
  end

  context 'when medium tracker type' do
    let(:cat2) { build(:cat, tracker_type: 'medium') }

    it 'create object with errors' do
      expect(cat2).to_not be_valid
      expect(cat2.errors.messages[:tracker_type]).to include "is not included in the list"
    end
  end

  context 'when lost_tracker passed' do
    it 'creates valid object' do
      expect(cat2).to be_valid
    end
  end
end

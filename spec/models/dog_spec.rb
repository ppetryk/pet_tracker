require 'rails_helper'

describe Dog, type: :model do
  let(:dog) { build(:dog) }

  it 'creates valid object' do
    expect(dog).to be_valid
  end

  context 'when pet type not correct' do
    let(:dog) { build(:dog, pet_type: 'Lion') }

    it 'creates object with errors' do
      expect(dog).to_not be_valid
      expect(dog.errors.messages[:pet_type]).to include "is not included in the list"
    end
  end

  context 'when tracker type not correct' do
    let(:dog) { build(:dog, tracker_type: 'large') }

    it 'creates object with errors' do
      expect(dog).to_not be_valid
      expect(dog.errors.messages[:tracker_type]).to include "is not included in the list"
    end
  end

  context 'when medium tracker type' do
    let(:dog) { build(:dog, tracker_type: 'medium') }

    it 'creates valid object' do
      expect(dog).to be_valid
    end
  end

  context 'when lost_tracker passed' do
    let(:dog) {  build(:dog, lost_tracker: false) }

    it 'creates object with errors' do
      expect(dog).to_not be_valid
      expect(dog.errors.messages[:lost_tracker]).to include "attribute not supported"
    end
  end
end

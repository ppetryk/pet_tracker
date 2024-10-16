require 'rails_helper'

describe Storages::Redis::ReportStorage do
  let(:key) { 'some_key' }
  subject { described_class.new(key) }
  let(:value) { { 'a' => 5 } }

  describe '#set' do
    it 'stores value as JSON' do
      expect_any_instance_of(Redis).to receive(:set).with(key, value.to_json)
      subject.set(value)
    end
  end

  describe '#get' do
    before { allow_any_instance_of(Redis).to receive(:get).and_return value.to_json }

    it 'converts value to hash' do
      expect(subject.get).to eq value
    end
  end
end

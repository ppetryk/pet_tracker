require 'rails_helper'

describe Storages::ReportStorage do
  let(:destination) { 'some_key' }
  subject { described_class.new(destination) }

  context 'when redis storage' do
    before { allow_any_instance_of(described_class).to receive(:configured_storage).and_return 'redis' }

    it 'creates object' do
      expect(subject.instance_variable_get(:@report_storage)).to be_a Storages::Redis::ReportStorage
    end
  end

  context 'when localhost storage' do
    before { allow_any_instance_of(described_class).to receive(:configured_storage).and_return 'localstorage' }

    it 'raises exception' do
      expect { subject }.to raise_error(StandardError, 'Unrecognized report storage')
    end
  end
end

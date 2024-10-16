require 'rails_helper'

describe 'Api Pets', type: :request do
  let(:hash_response) { JSON.parse(response.body) }

  describe 'POST #create' do
    let(:pet_type) { 'Dog' }
    let(:tracker_type) { 'big' }
    let(:owner_id) { 124 }
    let(:in_zone) { true }

    let(:params) { { pet_type: pet_type, tracker_type: tracker_type, owner_id: owner_id, in_zone: in_zone } }
    let(:record) { Pet.find(hash_response['id']) }

    it 'creates object' do
      post '/api/pets', params: params

      expect(response).to be_created
      expect(record.pet_type).to eq pet_type
      expect(record.tracker_type).to eq tracker_type
      expect(record.owner_id).to eq owner_id
      expect(record.in_zone).to eq in_zone
    end

    context 'when pet type not correct' do
      let(:pet_type) { 'Lion' }

      it 'fails with errors' do
        post '/api/pets', params: params

        expect(response).to be_bad_request
        expect(hash_response['errors']['pet_type']).to include "Attribute not supported"
      end
    end
  end

  describe 'PUT #update' do
    let(:dog) { create(:dog) }
    let(:in_zone) { false }

    let(:params) { { in_zone: in_zone } }

    it 'updates object' do
      put "/api/pets/#{dog.id}", params: params

      expect(response).to be_ok
      expect(dog.reload.in_zone).to eq in_zone
    end
  end

  describe 'GET #show' do
    let(:cat2) { create(:cat, lost_tracker: lost_tracker) }
    let(:lost_tracker) { true }

    it 'shows object' do
      get "/api/pets/#{cat2.id}"

      expect(response).to be_ok
      expect(hash_response['id']).to eq cat2.id
      expect(hash_response['lost_tracker']).to eq cat2.lost_tracker
    end
  end

  describe 'POST #not_in_zone' do
    let!(:dog1) { create(:dog, tracker_type: 'small', in_zone: false) }
    let!(:dog2) { create(:dog, tracker_type: 'big', in_zone: true) }
    let!(:dog3) { create(:dog, tracker_type: 'small', in_zone: false) }
    let!(:dog4) { create(:dog, tracker_type: 'small', in_zone: false) }
    let!(:dog5) { create(:dog, tracker_type: 'medium', in_zone: false) }

    let!(:cat1) { create(:cat, tracker_type: 'big', in_zone: false) }
    let!(:cat2) { create(:cat, tracker_type: 'small', in_zone: true) }
    let!(:cat3) { create(:cat, tracker_type: 'small', in_zone: true) }
    let!(:cat4) { create(:cat, tracker_type: 'big', in_zone: false) }
    let!(:cat5) { create(:cat, tracker_type: 'small', in_zone: false) }

    let(:expected_response) { { 'dogs' => { 'small' => 3, 'medium' => 1 }, 'cats' => { 'big' => 2, 'small' => 1 } } }

    it 'calculates pets' do
      expect_any_instance_of(Storages::Redis::ReportStorage).to receive(:set).with(expected_response)
      post '/api/pets/not_in_zone'

      expect(response).to be_ok
      expect(hash_response).to eq expected_response
    end
  end
end

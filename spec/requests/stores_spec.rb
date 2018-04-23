require 'rails_helper'

RSpec.describe 'Stores API', type: :request do
  # initialize test data 
  let!(:stores) { create_list(:store, 5) }
  let(:store_id) { stores.first.id }

  # Test suite for GET /todos
  describe 'GET /stores' do
    # make HTTP get request before each example
    before { get '/stores' }

    it 'returns stores' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /stores/:id' do
    before { get "/stores/#{store_id}" }

    context 'when the record exists' do
      it 'returns the store' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(store_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:store_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Store/)
      end
    end
  end

  describe 'POST /stores' do
    # valid payload
    let(:valid_attribute) { { name: 'Dairy' } }

    context 'when the request is valid' do
      before { post '/stores', params: valid_attribute }

      it 'creates a store' do
        expect(json['name']).to eq('Dairy')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/stores', params: {name: ''} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT /stores/:id' do
    let(:valid_attribute) { { name: 'Bread' } }

    context 'when the record exists' do
      before { put "/stores/#{store_id}", params: valid_attribute }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /stores/:id' do
    before { delete "/stores/#{store_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
require 'rails_helper'
include RequestSpecHelper

RSpec.describe CategoriesController, type: :controller do
  before do
    categories = FactoryBot.create_list(:category, 10)
    @category = categories.first
    @category_params = {
      name: 'Deli',
    }
  end

  let(:object) { @category }

  describe 'GET #index' do
    subject { get :index }
    it { is_expected.to be_successful }
    it { expect(json['categories'].length).to eq(Category.count) }
  end

  describe 'GET #show' do
    context 'should respond with valid info about the category' do
      subject { get :show, params: { id: object.id } }
      specify { expect(json['category']['id']).to eq(object.id) }
    end
    
    context 'should respond with http error if invalid id' do
      subject { get :show, params: { id: 'hi' } }
      it { is_expected.to have_http_status :not_found }
      it { expect(json).to have_key('error') }
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      subject { post :create, params: { id: object.id, 'category' => @category_params} }
      it { is_expected.to be_successful }
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      subject { put :update, params: { id: object.id, 'category' => @category_params } }
      it { is_expected.to be_successful }
    end

    context 'with invalid attributes' do
      let(:test_attrs) { @category_params.merge(status: 'hello') }
      subject { put :update, params: { id: object.id, 'category' => test_attrs } }
      it { is_expected.to have_http_status :not_acceptable }
      it { expect(json).to have_key('error') }
    end

    context 'with ID that does not exist' do
      subject { put :update, params: { id: 'hi' } }
      it { is_expected.to be_not_found }
      specify { expect(json['error']).to eq('Category hi not found') }
    end
  end

  context 'DELETE #destroy' do
    context 'successful delete' do
      subject { delete :destroy, params: { id: object.id } }
      it { is_expected.to be_successful }
    end

    context 'with ID that does not exist' do
      subject { delete :destroy, params: { id: 'hi' } }
      it { is_expected.to be_not_found }
      specify { expect(json['error']).to eq('Category hi not found') }
    end
  end
end


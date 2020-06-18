# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransformersController, type: :controller do
  let(:transformer) { FactoryBot.create(:transformer) }
  let(:valid_url) { { user_url: 'google.com' }    }
  let(:invalid_url) { { user_url: 'goo' } }
  let(:number_of_symbols) { Transformer::NUMBER_OF_SYMBOLS }
  before do
    transformer = double(:fake_trans)
    allow(Generator).to receive(:new).and_return(transformer)
    allow(transformer).to receive(:generating_mix).and_return('as')
  end

  describe 'POST create ' do
    context 'with valid data' do
      before do
        post :create, params: { transformer: valid_url }
      end
      it { expect(response).to be_successful }
      it { expect(Transformer.count).to eq(1) }
      it { expect(JSON.parse(response.body))
               .to eq({'nickname' => 'as', 'redirect_url' => 'http://test.host/as'}) }
      it { expect((JSON.parse(response.body)['nickname']).length).to eq(number_of_symbols) }
    end

    context 'with invalid data' do
      before do
        post :create, params: { transformer: invalid_url }
      end

      it { expect(JSON.parse(response.body)).to eq('user_url' =>  ['Valid URL required']) }
      it { expect { response }.to_not change(Transformer, :count) }
    end
  end

  describe 'GET show' do
    context 'url with http' do
      let(:url) { 'http://google.com' }
      let(:transformer) { FactoryBot.create(:transformer, user_url: url) }
      subject { get :show, params: { nickname: transformer.nickname } }

      it 'redirects to url with http' do
        expect(subject).to redirect_to(url)
      end
    end

    context 'url with https' do
      let(:url) { 'https://google.com' }
      let(:transformer) { FactoryBot.create(:transformer, user_url: url) }
      subject { get :show, params: { nickname: transformer.nickname } }

      it 'redirects to url with https' do
        expect(subject).to redirect_to(url)
      end
    end

    context 'url without http' do
      let(:url) { 'google.com' }
      let(:transformer) { FactoryBot.create(:transformer, user_url: url) }
      subject { get :show, params: { nickname: transformer.nickname } }

      it 'redirects to url without http' do
        expect(subject).to redirect_to("http://#{url}")
      end
    end
  end

  describe 'short link does not exist' do
    before do
      get :show, params: { nickname: 'nickname' }
    end

    it { expect(response.status).to eq 404 }
  end

  describe 'GET destroy' do
    let!(:transformer) { FactoryBot.create(:transformer) }
    before do
      delete :destroy, params: { nickname: transformer.nickname }
    end
    it { expect(JSON.parse(response.body)).to eq('message' => 'removed') }
    it { expect(response).to be_successful }
    it { expect(Transformer.count).to eq(0) }
  end

  describe 'destroy non existed' do
    before do
      delete :destroy, params: { nickname: 'nickname' }, format: :json
    end
    it { expect(response.status).to eq 404 }
  end
end

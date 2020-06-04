# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransformersController, :type => :controller do

  let(:transformer) { FactoryBot.create(:transformer) }
  let(:valid_url) { {user_url: 'google.com'}    }
  let(:invalid_url) { { user_url: 'goo' } }
  let(:number_of_symbols) { Transformer::NUMBER_OF_SYMBOLS }
  before do
    trans = double(:fake_trans)
    allow(Generator).to receive(:new).and_return(trans)
    allow(trans).to receive(:generating_mix).and_return('as')
  end

  describe "POST create " do

    context "with valid data" do
      before do
        post :create, params: { transformer: valid_url }
      end
      it { expect(response).to be_successful }
      it { expect(Transformer.count).to eq(1) }
      it { expect(JSON.parse(response.body)).to eq({ "nickname" => 'as'}) }
      it { expect((JSON.parse(response.body)['nickname']).length).to eq(number_of_symbols)}
    end


    context "with invalid data" do
      before do
        post :create, params: { transformer: invalid_url }
      end

      it { expect(response).to_not be_successful }
      it { expect{response}.to_not change(Transformer, :count) }
      it { expect(response).to redirect_to transformers_path }
    end
  end

  describe "GET show" do
    before do
      get :show, params: { nickname: transformer.nickname}
    end

    it { expect(response).to be_successful }
    it { expect(JSON.parse(response.body)).to eq({ "user_url"=> transformer.user_url})}
  end

  describe "show do not exist" do
    before do
      get :show, params: { nickname: 'nickname'}
    end

    it { expect(response.status).to eq 404 }
  end


  describe "GET destroy" do
    let!(:transformer) { FactoryBot.create(:transformer) }
    before do
      delete :destroy, params: { nickname: transformer.nickname }
    end
    it { expect(JSON.parse(response.body)).to eq('message' => 'removed') }
    it { expect(response).to be_successful }
    it { expect(Transformer.count).to eq(0) }
  end

  describe " destroy non existed" do

    before do
      delete :destroy, params: { nickname: 'nickname' }, format: :json
    end

    it { expect(response.status).to eq 404 }
  end
end




# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransformersController, :type => :controller do

  let(:transformer) { FactoryBot.create(:transformer) }
  let(:valid_url) { {user_url: 'google.com'}    }
  let(:invalid_url) { { user_url: 'goo' } }
  before do
    trans = double(:fake_trans)
    allow(Generator).to receive(:new).and_return(trans)
    allow(trans).to receive(:generating_mix).and_return('asdfg')
  end

  describe "POST create " do

    context "with valid data" do
      before do
        post :create, params: { transformer: valid_url }
      end
      it { expect(response).to be_successful }
      it { expect(Transformer.count).to eq(1) }
      it { expect(JSON.parse(response.body)).to eq({ "nickname" => 'asdfg'}) }
      it { expect((JSON.parse(response.body)['nickname']).length).to eq(Transformer::NUMBER_OF_SYMBOLS)}
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

  describe "GET destroy" do
    let!(:transformer) { FactoryBot.create(:transformer) }
    subject {delete :destroy, params: { nickname: transformer.nickname }, format: :json}

    it { expect(response.body).to be_blank }
    it { expect(response).to be_successful }
    it { expect{subject}.to change(Transformer, :count).by(-1) }
    # it "after delete show success message " do
    #   # expect(JSON.parse(response.body)).to eq({message: 'link was deleted!'})
    #   # expected = { message: "removed" }
    #   # expect(response.parsed_body).to eq(expected)
    #   # expect(response.parsed_body['message']).should =='link was deleted!'
    # end
  end
end




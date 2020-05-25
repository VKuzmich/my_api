# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransformersController, :type => :controller do

  let(:transformer) { FactoryBot.create(:transformer) }

  before do
    trans = double(:fake_trans)
    allow(Generator).to receive(:new).and_return(trans)
    allow(trans).to receive(:generating_mix).and_return('asdfg')
  end

  describe "POST create" do

    it "has a 200 status code" do
      post :create, params: { transformer: {user_url: 'google.com'}}
      expect(response).to be_successful
      expect(Transformer.count).to eq(1)
      expect(JSON.parse(response.body)).to eq({ "nickname" => 'asdfg'})
    end

    it " saves data" do
      expect { transformer }.to change(Transformer, :count).by(1)
    end

    it " does not save data" do
      # count = Transformer.count
      # difference = 0
      # transformer.save.should eq(false)
      # new_count = Transformer.count
      # expect(new_count - count).to eq(difference)
      # expect { Counter.increment }.not_to change{Counter.count}
      #
      # post :create, { email: "new@studentexample" }
      # invalid_data {post :create, params: { transformer: {user_url: "fooo"} }}
      # expect { invalid_data }.to_not change(Transformer, :count).by(1)
      # expect(subject).to redirect_to(Transformer.new)
    end

    it "render json" do
      post :create, params: { transformer: {user_url: transformer.user_url}}, format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['nickname'].length).to eq(Transformer::NUMBER_OF_SYMBOLS)
    end

  end

  describe "GET show" do
    it "has a 200 status code" do
      get :show, params: { nickname: transformer.nickname}
      expect(response).to be_successful
    end
  end

  describe "GET destroy" do
    let!(:transformer) { FactoryBot.create(:transformer) }
    subject {delete :destroy, params: { nickname: transformer.nickname }, format: :json}


    it { expect(response.body).to be_blank }
    it { expect(response).to be_successful }
    it { expect{subject}.to change(Transformer, :count).by(-1) }
    it "after delete show success message " do
      # expect(JSON.parse(response.body)).to eq({message: 'link was deleted!'})
      # expected = { message: "removed" }
      # expect(response.parsed_body).to eq(expected)
      # expect(response.parsed_body['message']).should =='link was deleted!'

      # @hash = { "info" => "link was deleted!"}
      # expect(JSON.parse(response.body)).to eq(@hash)
      # parsed_body = JSON.parse(response.body)
      # expect(JSON.parse(response.body['info'])).to eq("link was deleted!")
      #
    end
  end
end




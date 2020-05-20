# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransformersController, :type => :controller do
  # let(:transform) { FactoryBot.create(:transformer) }

  let(:transformer) { FactoryBot.create(:transformer) }
  describe "POST create" do
    it "has a 200 status code" do

      post :create, params: { transformer: {user_url: transformer.user_url}}
      expect(response).to be_successful
    end
  end

  describe "GET show" do
    it "has a 200 status code" do
      get :show, params: { nickname: transformer.nickname}
      expect(response).to be_successful
    end
  end
end



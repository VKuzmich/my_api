require 'rails_helper'

RSpec.describe Transformer, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:user_url) }
    it { is_expected.to allow_value('http://foo.com').for(:user_url) }
    it { is_expected.to allow_value('https://foo.com').for(:user_url) }
    it { is_expected.to allow_value('foo.com').for(:user_url) }
    it { is_expected.not_to allow_value('.foocom').for(:user_url) }
    it { is_expected.not_to allow_value('http//foo.com').for(:user_url) }
    it { is_expected.not_to allow_value('http:/foo.com').for(:user_url) }
    it { is_expected.not_to allow_value('http://foo..com').for(:user_url) }
    it { is_expected.not_to allow_value('buz').for(:user_url)}
  end

  describe 'before_save nickname' do

    let(:model) { build(:transformer) }

    it " nickname " do
      expect(model.nickname).to eq(nil)
    end

    it '' do
      expect(Transformer.count).to eq(0)
    end
  end

  describe "after save" do

    let(:model) { build(:transformer) }

    it "nickname has value" do
      trans = double(:fake_trans)
      allow(Generator).to receive(:new).and_return(trans)
      allow(trans).to receive(:generating_mix).and_return('asdfg')
      model.save
      expect(model.nickname).to eq('asdfg')
    end

    it 'add + 1 to db' do
      model.save
      expect(Transformer.count).to eq(1)
    end
  end
end
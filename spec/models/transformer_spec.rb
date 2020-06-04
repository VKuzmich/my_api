require 'rails_helper'

RSpec.describe Transformer, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:user_url) }
    it { is_expected.to allow_value('http://foo.com').for(:user_url) }
    it { is_expected.to allow_value('https://foo.com').for(:user_url) }
    it { is_expected.to allow_value('foo.com').for(:user_url) }
    it { is_expected.to allow_value('f.co').for(:user_url) }
    it { is_expected.not_to allow_value('.foocom').for(:user_url) }
    it { is_expected.not_to allow_value('http//foo.com').for(:user_url) }
    it { is_expected.not_to allow_value('http:/foo.com').for(:user_url) }
    it { is_expected.not_to allow_value('http://foo..com').for(:user_url) }
    it { is_expected.not_to allow_value('buz').for(:user_url)}
    it { is_expected.not_to allow_value('b.').for(:user_url)}
  end

  describe 'before_save nickname' do
    let(:model) { build(:transformer) }

    it "no nickname records" do
      expect(model.nickname).to eq(nil)
    end

    it 'no record in database' do
      expect(Transformer.count).to eq(0)
    end
  end

  describe '.generate_nickname' do
    let(:fake_model) { create(:transformer) }
    let!(:transform1) { Transformer.create(user_url: "find.ua") }
    let!(:transform2) { Transformer.create(user_url: "qwe.rt") }
    before do
    end

    it 'generate unique nickname in db' do
      generator_instance = double(:fake_trans1)
      allow(Generator).to receive(:new).and_return(generator_instance)
      allow(generator_instance).to receive(:generating_mix)
                                       .and_return(transform1.nickname, transform2.nickname, 'qwerty', 'asdf')
      expect(Generator).to receive(:new).once
      expect(generator_instance).to receive(:generating_mix).exactly(3).times
      expect(Transformer.create(user_url: "new.ua").nickname).to eq('qwerty')
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

    it 'add one record to db' do
      model.save
      expect(Transformer.count).to eq(1)
    end
  end
end
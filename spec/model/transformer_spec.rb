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
    let!(:symbols) { Generator.new.generating_mix(5) }

    it 'should accept generated symbols ' do
      instance_double("Transformer", nickname: :symbols)
    end

    it 'should accept certain number of symbols ' do
     should validate_length_of(:nickname).is_equal_to(Transformer::NUMBER_OF_SYMBOLS)
    end
  end
end
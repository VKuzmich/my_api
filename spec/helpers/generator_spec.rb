# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Generator, :type => :helper do
  ALLOWED_LETTERS = %w[a c d e f h j k m n p q r t u v w x y].freeze
  ALLOWED_NUMBERS = %w[2 3 4 5 6 7 8 9].freeze
  ALLOWED_CAPITALS = %w[A C D E F H J K L M N P Q R T U V W X Y].freeze
  ALLOWED_SYMBOLS = %w[  ].freeze
  DEFAULT_NUMBERS = 8

  describe "initialization" do
    let(:generator) {Generator.new}
    let(:users_number_of_symbols) { 5 }
    let(:default_number_of_symbols) { 8 }
    let(:zero_number_of_symbols) { 0 }
    let(:negative_number_of_symbols) { -5 }
    context "initializer" do
      it "get_mix gets empty array by default" do
        expect(generator.get_mix).to eq([])
      end
    end

    context 'checking .generating_mix with the value of numbers of symbols' do
      it ".generating_mix receive default numbers of symbols" do
        d = generator.generating_mix(default_number_of_symbols)
        expect(d.length).to eq DEFAULT_NUMBERS
      end

      it ".generating_mix receive users numbers of symbols" do
        d = generator.generating_mix(users_number_of_symbols)
        expect(d.length).to eq 5
      end

      it ".generating_mix receive zero numbers of symbols and raise ArgumentError" do
        expect { generator.generating_mix(zero_number_of_symbols) }.to raise_error(ArgumentError)
      end

      it ".generating_mix receives negative numbers of symbols and raise ArgumentError" do
        expect { generator.generating_mix(negative_number_of_symbols) }.to raise_error(ArgumentError)
      end
    end
  end
end

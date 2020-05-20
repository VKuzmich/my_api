class Transformer < ApplicationRecord
  NUMBER_OF_SYMBOLS = 5
  validates :user_url,
            presence: true,
            format: { with: %r"\A(https?://)?[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]{2,6}(/.*)?\Z"i,
                      :message => "Valid URL required"}
  # validates_length_of :nickname, is: NUMBER_OF_SYMBOLS

  before_save :generic_symbols

  def generic_symbols
    self.nickname = Generator.new.generating_mix(NUMBER_OF_SYMBOLS)
  end


end

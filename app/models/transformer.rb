class Transformer < ApplicationRecord
  NUMBER_OF_SYMBOLS = 5
  validates :user_url,
            presence: true,
            format: { with: %r"\A(https?://)?[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]{2,6}(/.*)?\Z"i,
                      :message => "Valid URL required"}

  before_save :set_nickname

  def set_nickname
    self.nickname = generate_nickname
  end

  def generate_nickname
    begin
      nickname = Generator.new.generating_mix(NUMBER_OF_SYMBOLS)
    end while Transformer.where(nickname: nickname).exists?
    nickname
  end
end

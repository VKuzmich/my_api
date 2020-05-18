class Transformer < ApplicationRecord
  before_save do
    self.nickname = Generator.new.generating_mix(5)
  end
end

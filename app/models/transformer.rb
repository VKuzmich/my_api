class Transformer < ApplicationRecord
  before_save do
    self.nickname = "nickname_#{user_url}"
  end
end

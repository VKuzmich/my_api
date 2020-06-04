class Transformer < ApplicationRecord
  NUMBER_OF_SYMBOLS = 2
  validates :user_url,
            presence: true,
            format: { with: %r"\A(https?://)?[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]{2,6}(/.*)?\Z"i,
                      :message => "Valid URL required"}

  before_save :set_nickname

  def set_nickname
    self.nickname = generate_nickname
  end

  def generate_nickname
    # gen_start = time_start = Time.now
    counter = total_count =  0
    number_of_symbols = NUMBER_OF_SYMBOLS
    generator = Generator.new

    begin
      counter += 1
      total_count += 1
      nickname = generator.generating_mix(number_of_symbols)
      # time_spent = Time.now - time_start
      if counter >= 25
        number_of_symbols += 1
        # time_start = Time.now
        counter = 0
      end
      # puts "Time consumed: #{time_spent}"
      # if time_spent > 1.second
      #   @num_sym += 1
      #   time_start = Time.now
      # end
    end while Transformer.where(nickname: nickname).exists?
    puts "Number of trials: #{total_count}"
    # puts "Number of trials: #{counter}"
    # puts "Time consumed: #{Time.now - gen_start}"
    nickname
  end
end

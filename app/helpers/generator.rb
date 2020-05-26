class Generator
  ALLOWED_LETTERS = %w[a c d e f h j k m n p q r t u v w x y]
  ALLOWED_NUMBERS = %w[2 3 4 5 6 7 8 9]
  ALLOWED_CAPITALS = %w[A C D E F H J K L M N P Q R T U V W X Y]
  ALLOWED_SYMBOLS = %w[  ]
  DEFAULT_NUMBERS = 8

  attr_accessor :get_mix

  def initialize
    super
    @get_mix = []
  end

  def generating_mix(number_of_symbols = DEFAULT_NUMBERS)
    raise(ArgumentError, 'negative array size') if number_of_symbols <= 0

    @get_mix = [*ALLOWED_LETTERS, *ALLOWED_NUMBERS,
                  *ALLOWED_CAPITALS, *ALLOWED_SYMBOLS].sample(number_of_symbols)
    @get_mix.join
  end
end

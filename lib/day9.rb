class Day9
  class << self
    def find_encryption_weakness(input, preamble_size)
      invalid_number = find_invalid_encoding(input, preamble_size)
      numbers = input.split("\n").map(&:to_i)
      arguments = ContinguousArgumentsFinder.new(invalid_number, numbers).call

      [arguments.max, arguments.min].sum
    end

    def find_invalid_encoding(input, preamble_size)
      numbers = input.split("\n").map(&:to_i)

      numbers.find.with_index do |number, index|
        next if index < preamble_size

        preamble = numbers[index - preamble_size...index]

        !is_valid?(number, preamble)
      end
    end

    def is_valid?(number, preamble)
      sorted_preamble = preamble.sort

      return false if number > sorted_preamble.last(2).sum || number < sorted_preamble.first(2).sum

      halve = number.to_f / 2
      half_index = sorted_preamble.find_index { |prenum| prenum > halve }
      higher_half = sorted_preamble[half_index..-1]
      lower_half = sorted_preamble[0...half_index]

      higher_half.any? { |highnum| lower_half.any? { |lownum| lownum.eql?(number - highnum) } }
    end
  end

  class ContinguousArgumentsFinder
    def initialize(sum, numbers)
      @sum = sum
      @numbers = numbers
      @arguments = []
    end

    def call
      numbers.find.with_index do |_, index|
        continguous_arguments(index)
      end

      arguments
    end

    private

    def continguous_arguments(index)
      arguments << numbers[index]

      if arguments.sum.eql?(sum)
        true
      elsif arguments.sum > sum
        self.arguments = []

        false
      else
        continguous_arguments(index + 1)
      end
    end

    attr_accessor :arguments
    attr_reader :sum, :numbers
  end
end

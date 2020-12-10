class Day10
  class << self
    def calculate_jolt_differences(input)
      numbers = input.split("\n").map(&:to_i)
      diffs = JoltDiffCalculator.new(numbers).call

      diffs[0] * diffs[2]
    end

    def calculate_possible_arrangements(input)
      sorted_numbers = [0] + input.split("\n").map(&:to_i).sort
      sliced = sorted_numbers.slice_when { |num_1, num_2| num_2 - num_1 == 3 }

      sliced.inject(1) do |aggr, nums_group|
        aggr * ArrangementsCalculator.new(nums_group).call
      end
    end
  end

  class ArrangementsCalculator
    def initialize(numbers)
      @numbers = numbers
      @arrangements_count = 0
    end

    def call
      self.arrangements_count = 1 # initial 1 for all adapters in subgroup

      count_arrangements_for(numbers)

      arrangements_count
    end

    private

    def count_arrangements_for(collection)
      collection.each_with_index do |_, index|
        next if index.eql?(0) || index.eql?(collection.size - 1)
        next unless can_be_removed?(index, collection)

        self.arrangements_count = arrangements_count + 1

        subcollection = [collection[index - 1]] + collection[index + 1..-1]

        count_arrangements_for(subcollection)
      end
    end

    def can_be_removed?(index, collection)
      collection[index + 1] - collection[index - 1] <= 3
    end

    attr_reader :numbers
    attr_accessor :arrangements_count
  end

  class JoltDiffCalculator
    def initialize(numbers)
      @numbers = numbers
      @differences = []
    end

    def call
      self.differences = [0, 0, 0]

      adjusted_numbers = numbers.sort
      adjusted_numbers.unshift(0)
      adjusted_numbers.push(adjusted_numbers.last + 3)

      adjusted_numbers.each_with_index do |number, index|
        break unless adjusted_numbers[index + 1]

        diff = adjusted_numbers[index + 1] - number

        differences[diff - 1] += 1
      end

      differences
    end

    private

    attr_accessor :differences
    attr_reader :numbers
  end
end

# frozen_string_literal: true

class Day15
  class << self
    def find_spoken_twentytwenty(input)
      SpokenNumberFinder.new(input, 2020).call
    end

    def find_spoken_thirtymln(input)
      SpokenNumberFinder.new(input, 30_000_000).call
    end
  end

  class SpokenNumberFinder
    attr_accessor :last_spoken

    def initialize(input, number)
      @starting = input
      @last_spoken = nil
      @memory = {}
      @xth_number = number

      parse_starting
    end

    def call
      range = (1..xth_number).drop(starting.size)

      range.each do |turn|
        last_turn = turn - 1

        if memory[last_spoken].nil?
          memory[last_spoken] = last_turn
          self.last_spoken = 0
        else
          new_value = last_turn - memory[last_spoken]

          memory[last_spoken] = last_turn
          self.last_spoken = new_value
        end
      end

      last_spoken
    end

    private

    def parse_starting
      starting[0..-2].each_with_index do |number, index|
        memory[number] = index + 1
      end

      self.last_spoken = starting.last
    end

    attr_reader :memory, :starting, :xth_number
  end
end

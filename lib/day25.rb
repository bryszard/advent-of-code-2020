# frozen_string_literal: true

class Day25
  class << self
    def find_encryption_key(card_public_key, door_public_key)
      card_loop_size = LoopSizeFinder.new(card_public_key).call

      (1..card_loop_size).inject(1) do |aggr, _n|
        LoopRunner.run(aggr, door_public_key)
      end
    end
  end

  class LoopSizeFinder
    def initialize(public_key)
      @public_key = public_key
      @value = 1
    end

    def call
      loop_size = 0

      while value != public_key
        loop_size += 1
        run_round
      end

      loop_size
    end

    private

    def run_round
      self.value = LoopRunner.run(value)
    end

    attr_accessor :value
    attr_reader :public_key
  end

  class LoopRunner
    SUBJECT_NO = 7

    class << self
      def run(value, subject_no = SUBJECT_NO)
        (value * subject_no) % 20_201_227
      end
    end
  end
end

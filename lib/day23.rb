# frozen_string_literal: true

class Day23_3
  class << self
    def play_cups_game(input)
      cups = input.split("").map(&:to_i)
      ((cups.max + 1)..1_000_000).each { |value| cups << value }
      crab_cups = CupsGame.new(cups)

      crab_cups.play(10_000_000)

      next_one_value = crab_cups.cups_by_value[1].next.value
      next_next_one_value = crab_cups.cups_by_value[1].next.next.value

      next_one_value * next_next_one_value
    end
  end

  class CupsGame
    attr_reader :max_value, :cups_by_value
    attr_accessor :current_cup

    def initialize(configuration, max_value = nil)
      @max_value = max_value.nil? ? configuration.length : max_value
      @cups_by_value = {}
      first_cup = Cup.new(configuration[0])
      @cups_by_value[configuration[0]] = first_cup
      current_cup = first_cup
      configuration[1..-1].each do |value|
        next_cup = Cup.new(value)
        current_cup.next = next_cup
        @cups_by_value[value] = next_cup
        current_cup = next_cup
      end
      current_cup.next = first_cup
      @current_cup = first_cup
    end

    def play(iterations = 100)
      (1..iterations).each { |_| tick }
    end

    def tick
      pickup = find_pickup
      current_cup.next = pickup.last.next
      next_cup_value = current_cup.value - 1
      pickup_value = pickup.map(&:value)
      destination_cup = find_destination_cup(next_cup_value, pickup_value)
      tail_pickup = destination_cup.next
      destination_cup.next = pickup.first
      pickup.last.next = tail_pickup
      @current_cup = current_cup.next
    end

    private

    def find_destination_cup(next_cup_value, pickup_value)
      return find_destination_cup(next_cup_value - 1, pickup_value) if pickup_value.include?(next_cup_value)
      return find_destination_cup(max_value, pickup_value) if next_cup_value.zero?

      cups_by_value[next_cup_value]
    end

    def find_pickup
      first = current_cup.next
      second = first.next
      third = second.next
      [first, second, third]
    end

    class Cup
      attr_reader :value
      attr_accessor :next

      def initialize(value)
        @value = value
      end
    end
  end
end

class Day23_2
  class << self
    def play_cups_game(input)
      cups = input.split("").map(&:to_i)
      result = CupsGame.new(cups).call

      result.drop(1).join
    end
  end

  class CupsGame
    def initialize(cups)
      @state = cups + (10..1_000_000).to_a
      @rounds_played = 0
    end

    def call
      while rounds_played < 10_000_000
        run_round
      end

      lowest_index = state.index(1)

      state[lowest_index + 1] * state[lowest_index + 2]
    end

    private

    def run_round
      return if rounds_played >= 10_000_000

      current = state.shift
      triplet = state.shift(3)
      destination_cup = find_destination_cup(current, triplet)
      destination_index = state.index(destination_cup)

      state.insert(destination_index + 1, *triplet)
      state.push(current)

      p self.rounds_played = rounds_played + 1
    end

    attr_accessor :state, :rounds_played

    def find_destination_cup(current, triplet)
      if current - 1 > 0 && !triplet.include?(current - 1)
        current - 1
      elsif current - 2 > 0 && !triplet.include?(current - 2)
        current - 2
      elsif current - 3 > 0 && !triplet.include?(current - 3)
        current - 3
      elsif !triplet.include?(1_000_000)
        1_000_000
      elsif !triplet.include?(999_999)
        999_999
      else
        999_998
      end
    end
  end
end

class Day23_1
  class << self
    def play_cups_game(input)
      cups = input.split("").map(&:to_i)
      result = CupsGame.new(cups).call

      result.drop(1).join
    end
  end

  class CupsGame
    def initialize(cups)
      @state = cups
      @rounds_played = 0
    end

    def call
      run_round

      state.rotate(state.index(1))
    end

    private

    def run_round
      return if rounds_played >= 100

      current = state[0]
      triplet = state[1..3]
      new_state = state - triplet
      lower = new_state.select { |cup| cup < current }
      higher = new_state.select { |cup| cup > current }
      destination_cup = lower.max || higher.max
      destination_index = new_state.index(destination_cup)

      new_state.insert(destination_index + 1, *triplet)

      self.state = new_state.rotate
      self.rounds_played += 1

      run_round
    end

    attr_accessor :state, :rounds_played
  end
end

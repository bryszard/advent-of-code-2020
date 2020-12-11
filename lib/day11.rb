# frozen_string_literal: true

class Day11
  OCCUPIED = "#"
  FLOOR = "."
  EMPTY = "L"

  class << self
    def calculate_occupied_seats(input)
      initial_state = input.split("\n").map(&:chars)
      final_state = RuleApplierPartOne.new(initial_state).call

      final_state.join.count(OCCUPIED)
    end

    def calculate_occupied_seats_alt(input)
      initial_state = input.split("\n").map(&:chars)
      final_state = RuleApplierPartTwo.new(initial_state).call

      final_state.join.count(OCCUPIED)
    end
  end

  class RuleApplierPartTwo
    def initialize(initial_state)
      @current_state = initial_state
    end

    def call
      apply_rules

      current_state
    end

    private

    attr_accessor :current_state

    def apply_rules
      new_state = current_state.dup
      new_state = occupy_seats(new_state)
      new_state = empty_crowded_seats(new_state)

      unless new_state.eql?(current_state)
        self.current_state = new_state
        apply_rules
      end
    end

    def occupy_seats(input_state)
      output_state = []

      input_state.each_with_index do |row, row_index|
        output_state[row_index] ||= input_state[row_index].dup

        row.each_with_index do |status, column_index|
          position = Position.new(row_index, column_index, input_state)

          if status.eql?(EMPTY) && no_occupied_adjacent?(position)
            output_state[row_index][column_index] = OCCUPIED
          end
        end
      end

      output_state
    end

    def empty_crowded_seats(input_state)
      output_state = []

      input_state.each_with_index do |row, row_index|
        output_state[row_index] ||= input_state[row_index].dup

        row.each_with_index do |status, column_index|
          position = Position.new(row_index, column_index, input_state)

          if status.eql?(OCCUPIED) && at_least_five_adjacent_occupied?(position)
            output_state[row_index][column_index] = EMPTY
          end
        end
      end

      output_state
    end

    def no_occupied_adjacent?(position)
      !position.visible_adjacent_seats.index(OCCUPIED)
    end

    def at_least_five_adjacent_occupied?(position)
      position.visible_adjacent_seats.count(OCCUPIED) >= 5
    end
  end

  class Position
    def initialize(row, column, surroudings)
      @row = row
      @column = column
      @surroudings = surroudings
    end

    def visible_adjacent_seats
      [
        fetch_visible_seat_status(row, -1, column, -1),
        fetch_visible_seat_status(row, -1, column, 0),
        fetch_visible_seat_status(row, -1, column, 1),
        fetch_visible_seat_status(row, 0, column, -1),
        fetch_visible_seat_status(row, 0, column, 1),
        fetch_visible_seat_status(row, 1, column, -1),
        fetch_visible_seat_status(row, 1, column, 0),
        fetch_visible_seat_status(row, 1, column, 1)
      ].compact
    end

    private

    attr_reader :row, :column, :surroudings

    def fetch_visible_seat_status(row_index, row_direction, column_index, column_direction)
      new_row_index = row_index + row_direction
      new_column_index = column_index + column_direction

      return if new_row_index.negative? || new_column_index.negative?

      status = surroudings[new_row_index]&.[](new_column_index)

      if status.eql?(FLOOR)
        status = fetch_visible_seat_status(new_row_index, row_direction, new_column_index, column_direction)
      end

      status
    end
  end

  class RuleApplierPartOne
    def initialize(initial_state)
      @current_state = initial_state
    end

    def call
      apply_rules

      current_state
    end

    private

    attr_accessor :current_state

    def apply_rules
      new_state = current_state.dup
      new_state = occupy_seats(new_state)
      new_state = empty_crowded_seats(new_state)

      unless new_state.eql?(current_state)
        self.current_state = new_state
        apply_rules
      end
    end

    def occupy_seats(input_state)
      output_state = []

      input_state.each_with_index do |row, row_index|
        output_state[row_index] ||= input_state[row_index].dup

        row.each_with_index do |seat, column_index|
          if seat.eql?(EMPTY) && no_occupied_adjacent?(row_index, column_index, input_state)
            output_state[row_index][column_index] = OCCUPIED
          end
        end
      end

      output_state
    end

    def empty_crowded_seats(input_state)
      output_state = []

      input_state.each_with_index do |row, row_index|
        output_state[row_index] ||= input_state[row_index].dup

        row.each_with_index do |seat, column_index|
          if seat.eql?(OCCUPIED) && at_least_four_adjacent_occupied?(row_index, column_index, input_state)
            output_state[row_index][column_index] = EMPTY
          end
        end
      end

      output_state
    end

    def no_occupied_adjacent?(row_index, column_index, state)
      !adjacent_seats(row_index, column_index, state).index(OCCUPIED)
    end

    def at_least_four_adjacent_occupied?(row_index, column_index, state)
      adjacent_seats(row_index, column_index, state).count(OCCUPIED) >= 4
    end

    def adjacent_seats(row_index, column_index, state)
      upper_row = row_index - 1
      lower_row = row_index + 1
      to_the_left = column_index - 1
      to_the_right = column_index + 1

      [
        fetch_seat_status(upper_row, to_the_left, state),
        fetch_seat_status(upper_row, column_index, state),
        fetch_seat_status(upper_row, to_the_right, state),
        fetch_seat_status(row_index, to_the_left, state),
        fetch_seat_status(row_index, to_the_right, state),
        fetch_seat_status(lower_row, to_the_left, state),
        fetch_seat_status(lower_row, column_index, state),
        fetch_seat_status(lower_row, to_the_right, state)
      ].compact
    end

    def fetch_seat_status(row_index, column_index, state)
      return unless row_index >= 0 && column_index >= 0

      state[row_index]&.[](column_index)
    end
  end
end

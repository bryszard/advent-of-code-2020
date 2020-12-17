require "active_support/core_ext/object"

class Day17_1
  ACTIVE = "#"
  INACTIVE = "."

  class << self
    def simulate_six_cycles(input)
      initial_dimensions = input.split("\n")
      dimensions = DimensionsRunner.new(prepare_dims(initial_dimensions)).call

      dimensions.values.map(&:values).flatten.map(&:values).flatten.count { |value| value.eql?(ACTIVE) }
    end

    private

    def prepare_dims(dimensions)
      hash_dimensions = { 0 => {} }

      dimensions.each_with_index do |row, row_index|
        cells = {}

        row.chars.each_with_index do |char, cell_index|
          cells[cell_index] = char
        end

        hash_dimensions[0][row_index] = cells
      end

      hash_dimensions
    end
  end

  class DimensionsRunner
    CYCLES = 6

    def initialize(initial_dimensions)
      @initial_dimensions = initial_dimensions
    end

    def call
      @dimensions = initial_dimensions.deep_dup

      CYCLES.times do |_n|
        apply_rules
      end

      dimensions
    end

    private

    attr_accessor :dimensions
    attr_reader :initial_dimensions

    def apply_rules
      new_state = dimensions.deep_dup

      dimensions.each do |z_coord, two_dimensions|
        two_dimensions.each do |y_coord, one_dimension|
          one_dimension.each do |x_coord, status|
            position = Position.new(z_coord, y_coord, x_coord, dimensions, new_state)

            if status.eql?(ACTIVE) && ![2, 3].include?(position.adjacent_cells.count { |value| value.eql?(ACTIVE) })
              new_state[z_coord][y_coord][x_coord] = INACTIVE
            elsif status.eql?(INACTIVE) && position.adjacent_cells.count { |value| value.eql?(ACTIVE) }.eql?(3)
              new_state[z_coord][y_coord][x_coord] = ACTIVE
            end

            position.adjacent_missing_to_activate.each do |coordinates|
              new_state[coordinates[0]] ||= {}
              new_state[coordinates[0]][coordinates[1]] ||= {}
              new_state[coordinates[0]][coordinates[1]][coordinates[2]] ||= {}

              new_state[coordinates[0]][coordinates[1]][coordinates[2]] = ACTIVE
            end
          end
        end
      end

      self.dimensions = new_state
    end
  end

  class Position
    def initialize(slice, row, column, surroudings, new_state)
      @slice = slice
      @row = row
      @column = column
      @surroudings = surroudings
      @new_state = new_state
    end

    def adjacent_cells
      coordinates = [1, 0, -1].repeated_permutation(3).to_a - [[0, 0, 0]]

      coordinates.map do |coordinate_group|
        check_cell_status(slice + coordinate_group[0], row + coordinate_group[1], column + coordinate_group[2])
      end.compact
    end

    def adjacent_missing_to_activate
      coordinates = [1, 0, -1].repeated_permutation(3).to_a - [0, 0, 0]

      missing = coordinates.select do |coordinate_group|
        check_cell_status(slice + coordinate_group[0], row + coordinate_group[1], column + coordinate_group[2]).nil?
      end

      to_activate = missing.select { |coordinate_group| should_activate?(coordinate_group) }

      to_activate.map do |coordinate_group|
        [slice + coordinate_group[0], row + coordinate_group[1], column + coordinate_group[2]]
      end
    end

    private

    attr_reader :slice, :row, :column, :surroudings, :new_state

    def check_cell_status(slice, row, column)
      surroudings.dig(slice, row, column)
    end

    def should_activate?(coordinate_group)
      position = Position.new(
        slice + coordinate_group[0],
        row + coordinate_group[1],
        column + coordinate_group[2],
        surroudings,
        new_state
      )

      position.adjacent_cells.count { |value| value.eql?(ACTIVE) }.eql?(3)
    end
  end
end

class Day17_2
  ACTIVE = "#"
  INACTIVE = "."

  class << self
    def simulate_six_cycles(input)
      initial_dimensions = input.split("\n")
      dimensions = DimensionsRunner.new(prepare_dims(initial_dimensions)).call

      dimensions.values.map(&:values).flatten.map(&:values).flatten.map(&:values).flatten.count { |value| value.eql?(ACTIVE) }
    end

    private

    def prepare_dims(dimensions)
      hash_dimensions = { 0 => { 0 => {} } }

      dimensions.each_with_index do |row, row_index|
        cells = {}

        row.chars.each_with_index do |char, cell_index|
          cells[cell_index] = char
        end

        hash_dimensions[0][0][row_index] = cells
      end

      hash_dimensions
    end
  end

  class DimensionsRunner
    CYCLES = 6

    def initialize(initial_dimensions)
      @initial_dimensions = initial_dimensions
    end

    def call
      @dimensions = initial_dimensions.deep_dup

      CYCLES.times do |_n|
        apply_rules
      end

      dimensions
    end

    private

    attr_accessor :dimensions
    attr_reader :initial_dimensions

    def apply_rules
      new_state = dimensions.deep_dup

      dimensions.each do |w_coord, three_dimensions|
        three_dimensions.each do |z_coord, two_dimensions|
          two_dimensions.each do |y_coord, one_dimension|
            one_dimension.each do |x_coord, status|
              position = Position.new(w_coord, z_coord, y_coord, x_coord, dimensions, new_state)

              if status.eql?(ACTIVE) && ![2, 3].include?(position.adjacent_cells.count { |value| value.eql?(ACTIVE) })
                new_state[w_coord][z_coord][y_coord][x_coord] = INACTIVE
              elsif status.eql?(INACTIVE) && position.adjacent_cells.count { |value| value.eql?(ACTIVE) }.eql?(3)
                new_state[w_coord][z_coord][y_coord][x_coord] = ACTIVE
              end

              position.adjacent_missing_to_activate.each do |coordinates|
                new_state[coordinates[0]] ||= {}
                new_state[coordinates[0]][coordinates[1]] ||= {}
                new_state[coordinates[0]][coordinates[1]][coordinates[2]] ||= {}
                new_state[coordinates[0]][coordinates[1]][coordinates[2]][coordinates[3]] ||= {}

                new_state[coordinates[0]][coordinates[1]][coordinates[2]][coordinates[3]] = ACTIVE
              end
            end
          end
        end
      end

      self.dimensions = new_state
    end
  end

  class Position
    def initialize(hyperslice, slice, row, column, surroudings, new_state)
      @hyperslice = hyperslice
      @slice = slice
      @row = row
      @column = column
      @surroudings = surroudings
      @new_state = new_state
    end

    def adjacent_cells
      coordinates = [1, 0, -1].repeated_permutation(4).to_a - [[0, 0, 0, 0]]

      coordinates.map do |coordinate_group|
        check_cell_status(
          hyperslice + coordinate_group[0],
          slice + coordinate_group[1],
          row + coordinate_group[2],
          column + coordinate_group[3]
        )
      end.compact
    end

    def adjacent_missing_to_activate
      coordinates = [1, 0, -1].repeated_permutation(4).to_a - [[0, 0, 0, 0]]

      missing = coordinates.select do |coordinate_group|
        check_cell_status(
          hyperslice + coordinate_group[0],
          slice + coordinate_group[1],
          row + coordinate_group[2],
          column + coordinate_group[3]
        ).nil?
      end

      to_activate = missing.select { |coordinate_group| should_activate?(coordinate_group) }

      to_activate.map do |coordinate_group|
        [
          hyperslice + coordinate_group[0],
          slice + coordinate_group[1],
          row + coordinate_group[2],
          column + coordinate_group[3]
        ]
      end
    end

    private

    attr_reader :hyperslice, :slice, :row, :column, :surroudings, :new_state

    def check_cell_status(hyperslice, slice, row, column)
      surroudings.dig(hyperslice, slice, row, column)
    end

    def should_activate?(coordinate_group)
      position = Position.new(
        hyperslice + coordinate_group[0],
        slice + coordinate_group[1],
        row + coordinate_group[2],
        column + coordinate_group[3],
        surroudings,
        new_state
      )

      position.adjacent_cells.count { |value| value.eql?(ACTIVE) }.eql?(3)
    end
  end
end

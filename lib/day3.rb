class Day3
  class << self
    DEFAULT_RIGHT_MOVE = 3
    DEFAULT_DOWN_MOVE = 1
    TREE = "#"

    def count_trees(input, right_move_by = DEFAULT_RIGHT_MOVE, down_move_by = DEFAULT_DOWN_MOVE)
      rows = input.split("\n")
      reduced_rows = rows.to_enum.with_index.select { |_, index| (index % down_move_by).zero? }
      map_width = reduced_rows.count * right_move_by + 1
      row_multiplier = (map_width / rows.first.size) + 1

      reduced_rows.map(&:first).to_enum.with_index.count do |row, index|
        extended_row = row * row_multiplier

        extended_row[index * right_move_by].eql?(TREE)
      end
    end

    def combine_five_paths(input)
      move_patterns = [
        [1, 1],
        [3, 1],
        [5, 1],
        [7, 1],
        [1, 2]
      ]

      move_patterns.reduce(1) do |product, pattern|
        product * count_trees(input, *pattern)
      end
    end
  end
end

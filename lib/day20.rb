# frozen_string_literal: true

class Day20
  class << self
    def calculate_non_monster_hashes(input)
      image = generate_image_from_puzzles(input)
      monsters = MonsterFinder.new(image).call

      image.count("#") - (monsters * 15)
    end

    def generate_image_from_puzzles(input)
      tiles = input.split("\n\n")
      row_count = Math.sqrt(tiles.size).to_i
      matching_puzzles = PuzzleMatcher.new(parse_tiles(tiles)).call
      ordered_puzzles = PuzzleArranger.new(matching_puzzles, row_count).call
      transformations = TransformationsAssigner.new(tiles, ordered_puzzles).call

      ImageGenerator.new(tiles, transformations).call
    end

    def calculate_corners(input)
      tiles = input.split("\n\n")
      puzzle_edges = parse_tiles(tiles)
      matching_counts = {}

      puzzle_edges.each do |key, edges|
        matching = edges.map do |edge|
          puzzle_edges.except(key).values.any? do |one_puzzle| one_puzzle.include?(edge) ||
            one_puzzle.map(&:reverse).include?(edge)
          end
        end

        matching_counts[key] = matching.count { |a| a }
      end

      matching_counts.select { |_, v| v.eql?(2) }.keys.inject(1) { |aggr, factor| aggr * factor }
    end

    private

    def parse_tiles(tiles)
      tiles.to_h do |tile|
        rows = tile.split("\n")
        header = rows[0]
        puzzle = rows[1..-1]
        rotated = puzzle.map(&:chars).transpose.map(&:join)

        [
          header[/\d+/].to_i,
          [
            puzzle.first,
            puzzle.last,
            rotated.first,
            rotated.last
          ]
        ]
      end
    end
  end

  class MonsterFinder
    MONSTER = [
      "                  # ",
      "#    ##    ##    ###",
      " #  #  #  #  #  #   "
    ]
    MONSTER_PATTERN = /.{18}\#.+\n\#.{4}\#{2}.{4}\#{2}.{4}\#{3}.+\n.{1}\#{1}.{2}\#{1}.{2}\#{1}.{2}\#{1}.{2}\#{1}.{2}\#{1}.{3}/

    EXAMPLE_PATTERN = /\#{2}.+\n\.{2}.+/

    def initialize(image)
      @image = image
    end

    def call
      count = 0
      actions = [
        :keep,
        :flip,
        :rotate_left,
        :rotate_right,
        :rotate_twice_left,
        :flip_and_rotate_left,
        :flip_and_rotate_right,
        :flip_and_rotate_twice_left
      ]

      actions.map do |transformation|
        break if count > 0

        transformed = ImageConverter.send(transformation, image.split("\n"))
        row_size = transformed.first.size

        (row_size - 20).times do |n|
          res = transformed.map { |row| row[n..-1] }.join("\n").scan(MONSTER_PATTERN)

          count += res.count
        end
      end

      count
    end

    private

    attr_reader :image
  end

  class ImageConverter
    class << self
      def keep(image)
        image
      end

      def flip(image)
        image.reverse
      end

      def rotate_left(image)
        image.map(&:chars).transpose.reverse.map(&:join)
      end

      def rotate_twice_left(image)
        rotate_left(rotate_left(image))
      end

      def rotate_right(image)
        image.map(&:chars).reverse.transpose.map(&:join)
      end

      def flip_and_rotate_left(image)
        rotate_left(flip(image))
      end

      def flip_and_rotate_twice_left(image)
        rotate_twice_left(flip(image))
      end

      def flip_and_rotate_right(image)
        rotate_right(flip(image))
      end
    end
  end

  class ImageGenerator
    def initialize(tiles, transformations)
      @puzzles = parse_tiles(tiles)
      @transformations = transformations
    end

    def call
      transformed = run_transformations
      no_edges = transformed.map { |row| row.map { |puzzle| cut_edges(puzzle) } }

      assemble_image(no_edges)
    end

    private

    attr_reader :puzzles, :transformations

    def run_transformations
      transformations.map do |row|
        row.map do |arr|
          key = arr[0]
          action = arr[1]

          ImageConverter.send(action, puzzles[key])
        end
      end
    end

    def cut_edges(puzzle)
      puzzle.map { |row| row[1..-2] }[1..-2]
    end

    def assemble_image(no_edges)
      no_edges.map do |row|
        row.inject { |aggr, puzzle| aggr.zip(puzzle) }.map { |line| line.flatten.join }
      end.map { |row| row.join("\n") }.join("\n")
    end

    def parse_tiles(tiles)
      tiles.to_h do |tile|
        rows = tile.split("\n")
        header = rows[0]
        puzzle = rows[1..-1]

        [header[/\d+/].to_i, puzzle]
      end
    end
  end

  class TransformationsAssigner
    def initialize(tiles, ordered_puzzles)
      @edges = parse_tiles(tiles)
      @ordered_puzzles = ordered_puzzles
    end

    def call
      transformations = assign_transformations

      ordered_puzzles.zip(transformations).map { |arr| arr[0].zip(arr[1]) }
    end

    private

    attr_reader :tiles, :edges, :ordered_puzzles

    def assign_transformations
      transformations = []

      ordered_puzzles.each_with_index do |row, row_index|
        row.each_with_index do |cell, column_index|
          # UP, RIGHT, DOWN, LEFT
          adjacent_edges = [
            find_common_edge(cell, ordered_puzzles[row_index - 1]&.[](column_index)),
            find_common_edge(cell, ordered_puzzles[row_index][column_index + 1]),
            find_common_edge(cell, ordered_puzzles[row_index + 1]&.[](column_index)),
            find_common_edge(cell, ordered_puzzles[row_index][column_index - 1])
          ].map(&:presence).flatten

          transformations[row_index] ||= []
          transformations[row_index][column_index] = find_transformation(cell, adjacent_edges)
        end
      end

      transformations
    end

    def find_common_edge(cell, adjacent_cell)
      return if edges[adjacent_cell].nil?

      (edges[cell] & edges[adjacent_cell]).presence || (edges[cell].map(&:reverse) & edges[adjacent_cell])
    end

    def find_transformation(cell, adjacent_edges)
      edges_for_puzzle = edges[cell]
      top_edge = edges_for_puzzle[0]

      if !adjacent_edges.index(top_edge) && !adjacent_edges.index(top_edge.reverse)
        check_bottom_edge(cell, adjacent_edges)
      elsif adjacent_edges.index(top_edge.reverse)
        check_top_reverse(cell, adjacent_edges)
      elsif adjacent_edges.index(top_edge).eql?(0)
        :keep
      elsif adjacent_edges.index(top_edge).eql?(1)
        :rotate_right
      elsif adjacent_edges.index(top_edge).eql?(2)
        :rotate_twice_left
      elsif adjacent_edges.index(top_edge).eql?(3)
        :rotate_left
      end
    end

    def check_bottom_edge(cell, adjacent_edges)
      edges_for_puzzle = edges[cell]
      bottom_edge = edges_for_puzzle[2]

      if adjacent_edges.index(bottom_edge.reverse)
        check_bottom_reverse(cell, adjacent_edges)
      elsif adjacent_edges.index(bottom_edge).eql?(0)
        :rotate_twice_left
      elsif adjacent_edges.index(bottom_edge).eql?(2)
        :keep
      elsif adjacent_edges.index(bottom_edge).eql?(3)
        :rotate_right
      elsif adjacent_edges.index(bottom_edge).eql?(1)
        :rotate_left
      end
    end

    def check_top_reverse(cell, adjacent_edges)
      edges_for_puzzle = edges[cell]
      top_reverse = edges_for_puzzle[0].reverse

      if adjacent_edges.index(top_reverse).eql?(1)
        :flip_and_rotate_left
      elsif adjacent_edges.index(top_reverse).eql?(0)
        :flip_and_rotate_twice_left
      elsif adjacent_edges.index(top_reverse).eql?(3)
        :flip_and_rotate_right
      elsif adjacent_edges.index(top_reverse).eql?(2)
        :flip
      end
    end

    def check_bottom_reverse(cell, adjacent_edges)
      edges_for_puzzle = edges[cell]
      bottom_reverse = edges_for_puzzle[2].reverse

      if adjacent_edges.index(bottom_reverse).eql?(3)
        :flip_and_rotate_left
      elsif adjacent_edges.index(bottom_reverse).eql?(2)
        :flip_and_rotate_twice_left
      elsif adjacent_edges.index(bottom_reverse).eql?(1)
        :flip_and_rotate_right
      elsif adjacent_edges.index(bottom_reverse).eql?(0)
        :flip
      end
    end

    def parse_tiles(tiles)
      tiles.to_h do |tile|
        rows = tile.split("\n")
        header = rows[0]
        puzzle = rows[1..-1]
        rotated = puzzle.map(&:chars).transpose.map(&:join)

        [
          header[/\d+/].to_i,
          [
            puzzle.first,
            rotated.last,
            puzzle.last.reverse,
            rotated.first.reverse
          ]
        ]
      end
    end
  end

  class PuzzleArranger
    def initialize(matching_puzzles, rows_count)
      @matching_puzzles = matching_puzzles.transform_values(&:compact)
      @canvas = Array.new(rows_count).map { Array.new(rows_count) }
    end

    def call
      canvas[0][0] = matching_puzzles.select { |_key, edges| edges.count.eql?(2) }.keys.first

      fill_next(0, 0)

      # Not sure if I need to transpose, but it worked with example
      canvas.transpose
    end

    private

    attr_accessor :canvas
    attr_reader :matching_puzzles

    def fill_next(row_coord, column_coord)
      origin = canvas[row_coord][column_coord]
      edges = matching_puzzles[origin]

      case edges.size
      when 2
        handle_corner(row_coord, column_coord, edges)
      when 3
        handle_border(row_coord, column_coord, edges)
      when 4
        handle_inner(row_coord, column_coord, edges)
      else
        raise_error("Invalid puzzle with matching edges count: #{edges.size} at #{edges}")
      end
    end

    def handle_corner(row_coord, column_coord, edges)
      next_missing = edges.find { |edge| !canvas.flatten.include?(edge) }
      next_coords = find_next_coords(row_coord, column_coord)

      canvas[next_coords[0]][next_coords[1]] = next_missing

      fill_next(next_coords[0], next_coords[1])
    end

    def handle_border(row_coord, column_coord, edges)
      next_border = edges.find { |edge| [2, 3].include?(matching_puzzles[edge].size) && !canvas.flatten.include?(edge) }
      next_missing = next_border || edges.find { |edge| !canvas.flatten.include?(edge) }
      next_coords = find_next_coords(row_coord, column_coord)

      canvas[next_coords[0]][next_coords[1]] = next_missing

      fill_next(next_coords[0], next_coords[1])
    end

    def handle_inner(row_coord, column_coord, edges)
      return unless edges.any? { |edge| !canvas.flatten.include?(edge) }

      next_coords = find_next_coords(row_coord, column_coord)
      next_missing = edges.find do |edge|
        !canvas.flatten.include?(edge) && adjacent_values(*next_coords).all? { |adj_val| matching_puzzles[edge].include?(adj_val) }
      end

      canvas[next_coords[0]][next_coords[1]] = next_missing

      fill_next(next_coords[0], next_coords[1])
    end

    # Going right, then down, then left, then up
    def find_next_coords(row_coord, column_coord)
      if column_coord + 1 < canvas.size && !canvas[row_coord][column_coord + 1] && !missing_up?(row_coord, column_coord)
        [row_coord, column_coord + 1]
      elsif row_coord + 1 < canvas.size && !canvas[row_coord + 1][column_coord]
        [row_coord + 1, column_coord]
      elsif column_coord - 1 >= 0 && !canvas[row_coord][column_coord - 1]
        [row_coord, column_coord - 1]
      elsif row_coord - 1 >= 0 && !canvas[row_coord - 1][column_coord]
        [row_coord - 1, column_coord]
      end
    end

    def adjacent_values(row_coord, column_coord)
      [
        canvas[row_coord + 1][column_coord],
        canvas[row_coord - 1][column_coord],
        canvas[row_coord][column_coord + 1],
        canvas[row_coord][column_coord - 1]
      ].compact
    end

    def missing_up?(row_coord, column_coord)
      row_coord - 1 >= 0 && !canvas[row_coord - 1][column_coord]
    end
  end

  class PuzzleMatcher
    def initialize(tiles)
      @puzzle_edges = tiles
    end

    def call
      puzzle_edges.to_h do |key, edges|
        matching = edges.map do |edge|
          puzzle_edges.except(key).select do |_key, one_puzzle|
            one_puzzle.include?(edge) || one_puzzle.map(&:reverse).include?(edge)
          end.keys.first
        end

        [key, matching]
      end
    end

    private

    attr_reader :puzzle_edges
  end
end

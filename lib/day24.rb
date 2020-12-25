# frozen_string_literal: true

class Day24
  VECTORS = {
    "e" => Vector[2, 0],
    "se" => Vector[1, -2],
    "sw" => Vector[-1, -2],
    "w" => Vector[-2, 0],
    "nw" => Vector[-1, 2],
    "ne" => Vector[1, 2]
  }

  class << self
    def living_art_state(input)
      paths = input.split("\n")
      initial_map = TilesMap.new(paths).map
      runner = ArtMaker.new(initial_map, 100)

      runner.call

      runner.tiles_map.values.select(&:black).count
    end

    def count_black_tiles(input)
      paths = input.split("\n")
      tiles_map = TilesMap.new(paths)

      tiles_map.map.values.select(&:black).count
    end
  end

  class ArtMaker
    attr_accessor :tiles_map, :new_map
    attr_reader :rounds

    def initialize(tiles_map, rounds)
      @tiles_map = tiles_map
      @rounds = rounds
    end

    def call
      (1..rounds).each { run_round }
    end

    private

    def run_round
      to_flip, missing = find_flipping_and_missing
      to_initialize = find_missing_to_initialize(missing.uniq)

      flip_all(to_flip)
      create_new(to_initialize)
    end

    def find_flipping_and_missing
      to_flip = []
      missing = []

      tiles_map.each do |vector, tile|
        adjacent_black = tile.adjacent_tiles.select { |adj| adj[:black] }.count
        missing_for_tile = tile.adjacent_tiles.select { |adj| adj[:black].nil? }.map { |adj| adj[:coords] }

        if tile.black && ![1, 2].include?(adjacent_black)
          to_flip << vector
        elsif !tile.black && adjacent_black.eql?(2)
          to_flip << vector
        end

        missing += missing_for_tile
      end

      [to_flip, missing]
    end

    def find_missing_to_initialize(missing)
      to_initialize = []

      missing.each do |coords|
        new_tile = Tile.new(coords, true, tiles_map)
        adjacent_black = new_tile.adjacent_tiles.select { |adj| adj[:black] }.count

        next unless adjacent_black.eql?(2)

        to_initialize << coords
      end

      to_initialize
    end

    def flip_all(to_flip)
      to_flip.each do |coords|
        tiles_map[coords].flip
      end
    end

    def create_new(to_initialize)
      to_initialize.each do |coords|
        tiles_map[coords] = Tile.new(coords, true, tiles_map)
      end
    end
  end

  class TilesMap
    attr_accessor :map

    def initialize(paths)
      @map = {}

      parse_paths(paths)
    end

    private

    def parse_paths(paths)
      paths.each do |path|
        steps = path.scan(/(e|se|sw|w|nw|ne)/).flatten

        tile_vector = steps.inject(Vector[0, 0]) do |aggr, direction|
          aggr + VECTORS[direction]
        end

        map[tile_vector] ||= Tile.new(tile_vector, false, map)
        map[tile_vector].flip
      end
    end
  end

  class Tile
    attr_accessor :black, :tiles_map
    attr_reader :vector

    def initialize(vector, black, tiles_map)
      @vector = vector
      @black = black
      @tiles_map = tiles_map
    end

    def flip
      self.black = !black
    end

    def adjacent_tiles
      VECTORS.map do |_key, adjacent_vector|
        coords = vector + adjacent_vector

        {
          coords: coords,
          black: tiles_map[coords]&.black
        }
      end
    end
  end
end

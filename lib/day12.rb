# frozen_string_literal: true

require "matrix"

class Day12
  EAST = "E"
  WEST = "W"
  NORTH = "N"
  SOUTH = "S"
  RIGHT = "R"
  LEFT = "L"
  FORWARD = "F"

  class << self
    def calculate_final_distance(input)
      instructions = InstructionsParser.new(input.split("\n")).normalize
      x_axis = instructions.select { |instr| [EAST, WEST].include?(instr[0]) }
      y_axis = instructions.select { |instr| [NORTH, SOUTH].include?(instr[0]) }

      [axis_distance(x_axis, WEST), axis_distance(y_axis, SOUTH)].sum
    end

    def calculate_waypoint_distance(input)
      instructions = input.split("\n")
      final_position = WaypointNavigator.new(instructions).sail

      final_position.map(&:abs).sum
    end

    private

    def axis_distance(instructions, negative_direction)
      instructions.inject(0) do |aggr, instr|
        sign = instr[0].eql?(negative_direction) ? :- : :+

        aggr.send(sign, instr[1..-1].to_i)
      end.abs
    end
  end

  class WaypointNavigator
    CONFIG = {
      SOUTH => {
        index: 1,
        sign: :-
      },
      NORTH => {
        index: 1,
        sign: :+
      },
      WEST => {
        index: 0,
        sign: :-
      },
      EAST => {
        index: 0,
        sign: :+
      }
    }

    def initialize(instructions)
      @instructions = instructions
      @waypoint = Vector[10, 1]
    end

    def sail
      instructions.inject(Vector[0, 0]) do |position, instr|
        command = instr[0]
        value = instr[1..-1].to_i

        case command
        when FORWARD
          position += (waypoint * value)
        when NORTH, SOUTH, EAST, WEST
          adjust_waypoint(command, value)
        when RIGHT, LEFT
          rotate_waypoint(command, value)
        end

        position
      end
    end

    private

    attr_accessor :waypoint
    attr_reader :instructions

    def adjust_waypoint(command, value)
      adjustment = [0, 0]
      index = CONFIG[command][:index]
      sign = CONFIG[command][:sign]
      adjustment[index] = adjustment[index].send(sign, value)

      self.waypoint = waypoint + Vector.send(:[], *adjustment)
    end

    def rotate_waypoint(command, value)
      sign = command.eql?(RIGHT) ? :- : :+
      degrees = 0.send(sign, value)
      radians = (degrees * Math::PI) / 180
      x_1, y_1 = waypoint.to_a
      x_2 = (x_1 * Math::cos(radians).round - y_1 * Math::sin(radians).round)
      y_2 = (x_1 * Math::sin(radians).round + y_1 * Math::cos(radians).round)

      self.waypoint = Vector[x_2, y_2]
    end
  end

  class InstructionsParser
    DIRECTIONS_WHEEL = {
      0 => NORTH,
      90 => EAST,
      180 => SOUTH,
      270 => WEST
    }

    attr_accessor :normalized_instructions

    def initialize(instructions)
      @instructions = instructions
      @direction = 90
    end

    def normalize
      @normalized_instructions = instructions.dup

      instructions.each_with_index do |instruction, index|
        command = instruction[0]

        next unless [FORWARD, RIGHT, LEFT].include?(command)

        parse_single(command, index)
      end
    end

    private

    attr_accessor :direction
    attr_reader :instructions

    def parse_single(command, index)
      case command
      when FORWARD
        normalized_instructions[index][0] = DIRECTIONS_WHEEL[direction]
      when RIGHT, LEFT
        degrees = instructions[index][1..-1].to_i

        turn(command, degrees)
      end
    end

    def turn(command, degrees)
      sign = command.eql?(LEFT) ? :- : :+

      self.direction = direction.send(sign, degrees) % 360
    end
  end
end

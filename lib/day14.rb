# frozen_string_literal: true

class Day14
  class << self
    def sum_remaining_values(input)
      instructions = input.split("\n")
      memory = OverwritingMaskCompiler.new(instructions).run

      memory.compact.sum
    end

    def sum_remaining_values_part_2(input)
      instructions = input.split("\n")
      memory = FloatingAddressCompiler.new(instructions).run

      memory.values.sum
    end
  end

  class FloatingAddressCompiler
    attr_accessor :mask, :mem

    def initialize(instructions)
      @instructions = instructions
      @mask = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
      @mem = {}
    end

    def run
      instructions.each do |instruction|
        if instruction.start_with?("mask")
          self.mask = instruction.sub("mask = ", "")
        end

        if instruction.start_with?("mem")
          address = instruction.split(/(\[|\])/)[2].to_i
          addresses = apply_mask(address)

          addresses.each do |new_address|
            add_value(new_address.to_i(2), instruction)
          end
        end
      end

      mem
    end

    private

    attr_reader :instructions

    def apply_mask(address)
      relevant_mask = mask.chars.map.with_index do |char, index|
        next if char.eql?("0")

        [index, char]
      end.compact

      dynamic_address = relevant_mask.inject("%036b" % address) do |aggr, (index, char)|
        aggr[index] = char

        aggr
      end

      generate_addresses(dynamic_address)
    end

    def generate_addresses(dynamic_address)
      floating_count = dynamic_address.count("X")
      permutations = [1, 0].repeated_permutation(floating_count).to_a

      indexes_to_change = dynamic_address.chars.map.with_index do |value, index|
        next unless value.eql?("X")

        index
      end.compact

      permutations.map do |values|
        chars = dynamic_address.chars

        values.each_with_index do |value, index|
          chars[indexes_to_change[index]] = value
        end

        chars.join
      end
    end

    def add_value(address, instruction)
      value = instruction[/= \d+/][2..-1].to_i

      mem[address] = value
    end
  end

  class OverwritingMaskCompiler
    attr_accessor :mask, :mem

    def initialize(instructions)
      @instructions = adapt_for_eval(instructions)
      @mask = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
      @mem = []
    end

    def run
      instructions.each do |instruction|
        eval(instruction)

        if instruction.start_with?("mem")
          address = instruction.split(/(\[|\])/)[2].to_i

          apply_mask(address)
        end
      end

      mem
    end

    private

    def adapt_for_eval(instructions)
      instructions.map do |instr|
        if instr.start_with?("mask")
          instr.sub(/= (.+)/, '= "\1"').sub("mask", "self.mask")
        else
          instr
        end
      end
    end

    def apply_mask(address)
      binary_value = "%036b" % mem[address]
      relevant_mask = mask.chars.map.with_index do |value, index|
        next if value.eql?("X")

        [index, value]
      end.compact

      relevant_mask.each do |(index, value)|
        binary_value[index] = value
      end

      mem[address] = binary_value.to_i(2)
    end

    attr_reader :instructions
  end
end

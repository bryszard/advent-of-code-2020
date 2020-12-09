class Day8
  class << self
    def acc_value_before_infinite_loop(input)
      instructions = input.split("\n")

      Runner.new(instructions).run
    end

    def acc_value_with_loop_fixes(input)
      instructions = input.split("\n")

      Fixer.new(instructions, Runner).run_with_fixes
    end
  end

  class Fixer
    def initialize(instructions, runner_class)
      @original_instructions = instructions.freeze
      @next_fix_index = 0
      @runner_class = runner_class
      @runner = Runner.new(original_instructions)
    end

    def run_with_fixes
      runner.run

      if runner.executed_indexes.uniq != runner.executed_indexes
        index_to_fix = original_instructions.find_index.with_index do |instr, index|
          index >= next_fix_index && instr.start_with?(/(nop|jmp)/)
        end
        self.next_fix_index = index_to_fix + 1
        new_instructions = modify_instructions(index_to_fix)
        self.runner = Runner.new(new_instructions)

        run_with_fixes
      end

      runner.accumulator
    end

    private

    def modify_instructions(index_to_fix)
      new_instructions = original_instructions.dup
      command = new_instructions[index_to_fix].split(" ").first

      case command
      when "nop"
        new_instructions[index_to_fix] = new_instructions[index_to_fix].sub("nop", "jmp")
      when "jmp"
        new_instructions[index_to_fix] = new_instructions[index_to_fix].sub("jmp", "nop")
      end

      new_instructions
    end

    attr_reader :original_instructions, :runner_class
    attr_accessor :next_fix_index, :runner
  end

  class Runner
    attr_reader :executed_indexes, :accumulator

    def initialize(instructions)
      @instructions = instructions
      @executed_indexes = []
      @accumulator = 0
    end

    def run
      run_single_instruction(0)

      accumulator
    end

    private

    def run_single_instruction(instruction_index)
      executed_indexes << instruction_index

      return if index_starts_loop?(instruction_index) || instruction_index >= instructions.size

      command, value = instructions[instruction_index].split(" ")

      execute_command(command, value, instruction_index)
    end

    def index_starts_loop?(instruction_index)
      executed_indexes.count { |index| instruction_index.eql?(index) }.eql?(2)
    end

    def execute_command(command, value, instruction_index)
      case command
      when "nop"
        run_single_instruction(instruction_index + 1)
      when "acc"
        handle_acc_command(value, instruction_index)
      when "jmp"
        handle_jmp_command(value, instruction_index)
      end
    end

    def handle_acc_command(value, instruction_index)
      sign = value[0]
      number = value [1..-1].to_i
      self.accumulator = accumulator.send(sign, number)

      run_single_instruction(instruction_index + 1)
    end

    def handle_jmp_command(value, instruction_index)
      sign = value[0]
      number = value [1..-1].to_i

      next_index = instruction_index.send(sign, number)

      run_single_instruction(next_index)
    end

    attr_writer :executed_indexes, :accumulator
    attr_reader :instructions
  end
end

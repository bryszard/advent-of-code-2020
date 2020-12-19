# frozen_string_literal: true

class Day18_2
  EXPRESSION_REGEX = /(\([\d *+]+\))/
  ADDITION_REGEX = /([\d +]+ *)/

  class << self
    def sum_all_results(input)
      operations = input.split("\n")

      operations.map { |op| calc_alt_math(op) }.sum
    end

    def calc_alt_math(input)
      calc_tree(input)
    end

    private

    def calc_tree(input)
      new_input = input.dup
      matches = input.scan(EXPRESSION_REGEX).flatten

      matches&.each do |match|
        sub_input = match[1..-2]
        value = run_alt_math(sub_input)

        new_input.sub!(match, value.to_s)
      end

      if new_input.match?(EXPRESSION_REGEX)
        calc_tree(new_input)
      else
        run_alt_math(new_input)
      end
    end

    def run_alt_math(input)
      new_input = input.dup
      matches = input.scan(ADDITION_REGEX).flatten

      matches&.each do |match|
        next if match.strip.split(" ").size < 3

        elements = match.strip.split(" ")
        value = run_additions(elements)

        new_input.sub!(match, " #{value} ")
      end

      run_multiplications(new_input.strip.split(" "))
    end

    def run_additions(elements)
      new_first = elements[0].to_i.send(elements[1], elements[2].to_i)

      if elements.size > 3
        new_elements = [new_first, elements[3..-1]].flatten
        new_first = run_additions(new_elements)
      end

      new_first
    end

    def run_multiplications(elements)
      return elements.first.to_i if elements.size.eql?(1)

      new_first = elements[0].to_i.send(elements[1], elements[2].to_i)

      if elements.size > 3
        new_elements = [new_first, elements[3..-1]].flatten
        new_first = run_multiplications(new_elements)
      end

      new_first
    end
  end
end

class Day18_1
  EXPRESSION_REGEX = /(\([\d *+]+\))/

  class << self
    def sum_all_results(input)
      operations = input.split("\n")

      operations.map { |op| calc_alt_math(op) }.sum
    end

    def calc_alt_math(input)
      calc_tree(input)
    end

    private

    def calc_tree(input)
      new_input = input.dup
      matches = input.scan(EXPRESSION_REGEX).flatten

      matches&.each do |match|
        elements = match[1..-2].split(" ")
        value = run_alt_math(elements)

        new_input.sub!(match, value.to_s)
      end

      if new_input.match?(EXPRESSION_REGEX)
        calc_tree(new_input)
      else
        elements = new_input.split(" ")
        run_alt_math(elements)
      end
    end

    def run_alt_math(elements)
      new_first = elements[0].to_i.send(elements[1], elements[2].to_i)

      if elements.size > 3
        new_elements = [new_first, elements[3..-1]].flatten
        new_first = run_alt_math(new_elements)
      end

      new_first
    end
  end
end

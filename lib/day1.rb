class Day1
  DEFAULT_SUM_CHECK = 2020

  class << self
    def calculate_two(collection, sum_check = DEFAULT_SUM_CHECK)
      first_factor = nil
      second_factor = nil

      collection.each_with_index do |element, index|
        next if element > sum_check

        first_factor = element
        complement = sum_check - element
        second_factor = collection[index + 1..-1].find do |second_element|
          second_element.eql?(complement)
        end

        break if second_factor
      end

      second_factor ? first_factor * second_factor : nil
    end

    def calculate_three(collection, sum_check = DEFAULT_SUM_CHECK)
      first_factor = nil
      second_factor = nil

      collection.each_with_index do |element, index|
        next if element > sum_check
        next if collection[index + 1..-1].size < 2

        first_factor = element
        complement = sum_check - element
        second_factor = calculate_two(collection[index + 1..-1], complement)

        break if second_factor
      end

      second_factor ? first_factor * second_factor : nil
    end
  end
end

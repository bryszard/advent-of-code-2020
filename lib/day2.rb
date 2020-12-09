class Day2
  class << self
    def count_valid(input)
      rows = input.split("\n")

      rows.count do |row|
        range, letter, password = row.split(" ")
        min, max = range.split("-").map(&:to_i)

        validate_password(password, letter.delete(":"), min, max)
      end
    end

    def count_valid_alt(input)
      rows = input.split("\n")

      rows.count do |row|
        range, letter, password = row.split(" ")
        start, finish = range.split("-").map(&:to_i)

        validate_password_alt(password, letter.delete(":"), start - 1, finish - 1)
      end
    end

    private

    def validate_password(password, letter, min, max)
      letter_count = password.count(letter)

      letter_count >= min && letter_count <= max
    end

    def validate_password_alt(password, letter, start_index, stop_index)
      password[start_index].eql?(letter) ^ password[stop_index].eql?(letter)
    end
  end
end

class Day5
  class << self
    TOTAL_ROWS = 128
    TOTAL_COLUMNS = 8

    def find_highest_code(input)
      boarding_passes = input.split("\n")

      boarding_passes.map { |pass| calculate_seat_code(pass) }.max
    end

    def find_missing_code(input)
      boarding_passes = input.split("\n")
      codes_list = boarding_passes.map { |pass| calculate_seat_code(pass) }.sort
      range = codes_list.first..codes_list.last

      (range.to_a - codes_list).first
    end

    def calculate_seat_code(input)
      row = decode_row(input[0, 7])
      column = decode_column(input[7, 3])

      row * 8 + column
    end

    private

    def decode_row(row_code)
      bisect(row_code, "F", "B", TOTAL_ROWS)
    end

    def decode_column(column_code)
      bisect(column_code, "L", "R", TOTAL_COLUMNS)
    end

    def bisect(input, first_code, last_code, total)
      all_elements = 0..(total - 1)

      input.chars.inject(all_elements) do |aggr, letter|
        group_size = aggr.count / 2
        method = :first if letter.eql?(first_code)
        method = :last if letter.eql?(last_code)

        aggr.send(method, group_size)
      end.first
    end
  end
end

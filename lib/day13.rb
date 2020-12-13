# frozen_string_literal: true

class Day13
  class << self
    def find_earliest_bus(input)
      timestamp, buses_input = input.split("\n")
      bus_times = buses_input.split(",").reject { |bus_time| bus_time.eql?("x") }.map(&:to_i)
      buses_with_next_departure = bus_times.map { |bus_time| [bus_time, bus_time - (timestamp.to_i % bus_time)] }
      earliest = buses_with_next_departure.min_by { |bus_with_dep| bus_with_dep[1] }

      earliest[0] * earliest[1]
    end

    def find_perfect_timestamp(input)
      buses_input = input.split(",").map.with_index do |bus, index|
        next if bus.eql?("x")

        [bus.to_i, index]
      end.compact

      calculate_factor(buses_input)
    end

    private

    def calculate_factor(buses_input)
      mods = buses_input.map { |bus| bus[0] }
      remainders = buses_input.map { |bus| (bus[0] - bus[1]) % bus[0] }

      chinese_remainder(mods, remainders)
    end

    def chinese_remainder(mods, remainders)
      max = mods.inject(:*) # product of all moduli
      series = remainders.zip(mods).map { |r, m| (r * max * invmod(max / m, m) / m) }
      series.inject(:+) % max
    end

    def extended_gcd(a, b)
      last_remainder, remainder = a.abs, b.abs
      x, last_x, y, last_y = 0, 1, 1, 0

      while remainder != 0
        last_remainder, (quotient, remainder) = remainder, last_remainder.divmod(remainder)
        x, last_x = last_x - quotient * x, x
        y, last_y = last_y - quotient * y, y
      end

      return last_remainder, last_x * (a.negative? ? -1 : 1)
    end

    def invmod(e, et)
      g, x = extended_gcd(e, et)

      if g != 1
        raise 'Multiplicative inverse modulo does not exist!'
      end

      x % et
    end
  end
end

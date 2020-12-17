# frozen_string_literal: true

class Day16
  class << self
    def calculate_departure_fields(input)
      ticket = decode_your_ticket(input)

      ticket.select { |key, _| key.start_with?("departure") }.values.map(&:to_i).inject(1) { |aggr, val| aggr * val }
    end

    def decode_your_ticket(input)
      rules, your_data, tickets = input.split("\n\n")
      valid_tickets = select_valid(rules, tickets)
      field_indices = infer_field_indices(rules, valid_tickets)
      your_ticket = map_field_indices(field_indices, your_data)

      your_ticket
    end

    def count_invalid_values(input)
      rules, _, tickets = input.split("\n\n")
      ranges = extract_ranges(rules)
      values = extract_values(tickets)

      values.select do |value|
        !ranges.any? { |range| range.cover?(value) }
      end.sum
    end

    private

    def select_valid(rules, tickets)
      ranges = extract_ranges(rules)

      tickets.split("\n").drop(1).select do |ticket|
        values = ticket.split(",").map(&:to_i)

        values.all? { |value| ranges.any? { |range| range.cover?(value) } }
      end
    end

    def map_field_indices(field_indices, your_data)
      your_data.split("\n").drop(1).first.split(",").map.with_index do |value, index|
        [field_indices[index], value]
      end.to_h
    end

    def infer_field_indices(rules, valid_tickets)
      range_maps = extract_range_maps(rules)
      possibilities = check_possible_fits(range_maps, valid_tickets)

      enforce_order(possibilities)
    end

    def enforce_order(possibilities)
      ordered = {}
      reduced_list = possibilities.dup

      while possibilities.keys.size != ordered.keys.size || !reduced_list.values.all?(&:empty?)
        next_pair = reduced_list.reject { |_, value| value.empty? }.min_by { |_, value| value.size }
        field = next_pair[0]
        next_index = next_pair[1].first

        ordered[next_index] = field
        reduced_list.transform_values { |value| value.delete(next_index) }
      end

      ordered
    end

    def check_possible_fits(range_maps, valid_tickets)
      rules_indices = range_maps.keys.to_h { |key| [key, { selected: [], rejected: [] }] }

      valid_tickets.each do |ticket|
        values = ticket.split(",").map(&:to_i)

        values.each_with_index do |value, index|
          range_maps.each do |key, ranges|
            if to_select?(ranges, value, rules_indices, key, index)
              rules_indices[key][:selected] << index
            elsif to_reject?(ranges, value, rules_indices, key, index)
              rules_indices[key][:selected].delete(index)
              rules_indices[key][:rejected] << index
            end
          end
        end
      end

      rules_indices.transform_values { |value| value[:selected] }
    end

    def to_select?(ranges, value, rules_indices, key, index)
      ranges.any? { |range| range.cover?(value) } &&
        !rules_indices[key][:selected].include?(index) &&
        !rules_indices[key][:rejected].include?(index)
    end

    def to_reject?(ranges, value, rules_indices, key, index)
      !ranges.any? { |range| range.cover?(value) }
    end

    def extract_range_maps(rules)
      rules.split("\n").map do |rules_row|
        key, rest = rules_row.split(":")

        [key, rest.scan(/\d+-\d+/).map { |rule| start, finish = rule.split("-"); (start.to_i..finish.to_i) }]
      end.to_h
    end

    def extract_ranges(rules)
      rules.split("\n").map do |rules_row|
        rules_row.scan(/\d+-\d+/).map { |rule| start, finish = rule.split("-"); (start.to_i..finish.to_i) }
      end.flatten
    end

    def extract_values(tickets)
      tickets.split("\n").drop(1).map { |row| row.split(",") }.flatten.map(&:to_i)
    end
  end
end

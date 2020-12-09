# frozen_string_literal: true

class Day7
  class << self
    def calculate_outermost_options(input)
      rules = input.split("\n")
      parsed_rules = parse_rules(rules)

      find_paths_for("shiny gold", parsed_rules).count
    end

    def calculate_inner_bags(input)
      rules = input.split("\n")
      parsed_rules = parse_rules(rules)

      count_inner_bags_for("shiny gold", parsed_rules)
    end

    private

    def find_paths_for(color, rules_set)
      direct_matches = rules_set.select { |_, value| value.keys.include?(color) }.keys
      nested_matches = direct_matches.map { |inner_color| find_paths_for(inner_color, rules_set) }.flatten

      (direct_matches + nested_matches).uniq
    end

    def count_inner_bags_for(color, parsed_rules)
      top_rule = parsed_rules[color]
      nested_counts = top_rule.map do |inner_color, value|
        value.to_i * count_inner_bags_for(inner_color, parsed_rules) + value.to_i
      end

      nested_counts.sum
    end

    def parse_rules(rules)
      definitions = {}

      rules.each do |rule|
        outer, contained = rule.split("bags contain")
        single_colors = contained.split(", ")
        inner_rules = single_colors.map { |single_color| parse_inner_rule(single_color) }

        definitions[outer.strip] = inner_rules.inject(inner_rules.first) do |aggr, inner_rule|
          aggr&.merge!(inner_rule)
        end
      end

      definitions
    end

    def parse_inner_rule(rule)
      return {} if rule.match?("no other bags")

      value = rule.split(" ").first
      key = rule.split(" ").drop(1).take(2).join(" ")

      {
        key => value
      }
    end
  end
end

# frozen_string_literal: true

class Day19
  class << self
    def count_valid_messages(input, antiloop = false)
      rules, messages = input.split("\n\n")
      pattern_builder = PatternBuilder.new(rules.split("\n"), antiloop)
      pattern = pattern_builder.call

      messages.split("\n").count do |message|
        message.match?(pattern) && pattern_builder.additional_check(message)
      end
    end

    def additional_check(message, rules)

    end
  end

  class PatternBuilder
    def initialize(rules, antiloop)
      @rules = prepare_rules(rules)
      @antiloop = antiloop
    end

    def call
      rule = parse_rule(rules[0])

      Regexp.new(/\A#{rule}\z/)
    end

    def additional_check(message)
      return true unless rules[42] && rules[31]

      true
      # message.scan(parse_rule(rules[42])).size > message.scan(parse_rule(rules[31])).size
    end

    private

    def prepare_rules(rules)
      rules.to_h do |rule|
        parts = rule.split(": ")

        [parts[0].to_i, parts[1]]
      end
    end

    def parse_rule(rule)
      if rule.match?(/\A"\w"\z/)
        Regexp.new(rule.delete('"'))
      elsif rule.match?(/\|/)
        subrules = rule.split(" | ")
        complex_rule = subrules.map { |subrule| parse_rule(subrule) }

        Regexp.union(complex_rule)
      else
        subrule_keys = rule.split(" ").map(&:to_i)

        complex_rule = subrule_keys.map do |subrule_key|
          if antiloop && subrule_key.eql?(8)
            Regexp.new(/(#{parse_rule(rules[42])})+/).to_s
          elsif antiloop && subrule_key.eql?(11)
            rule_42 = parse_rule(rules[42])
            rule_31 = parse_rule(rules[31])

            Regexp.new(/#{rule_42}(#{rule_42}(#{rule_42}(#{rule_42}(#{rule_42}(#{rule_42}#{rule_31})?#{rule_31})?#{rule_31})?#{rule_31})?#{rule_31})?#{rule_31}/).to_s
          else
            parse_rule(rules[subrule_key]).to_s
          end
        end.join

        Regexp.new(complex_rule)
      end
    end

    attr_reader :rules, :antiloop
  end
end

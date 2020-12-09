class Day4
  class << self
    REQUIRED_FIELDS = %w(
      byr
      iyr
      eyr
      hgt
      hcl
      ecl
      pid
    ).freeze
    RULES = {
      "byr" => /\A(19[2-8][0-9]|199[0-9]|200[0-2])\z/,
      "iyr" => /\A(201[0-9]|2020)\z/,
      "eyr" => /\A(202[0-9]|2030)\z/,
      "hgt" => /\A((1[5-8][0-9]|19[0-3])cm|(59|6[0-9]|7[0-6])in)\z/,
      "hcl" => /\A#[a-f0-9]{6}\z/,
      "ecl" => /\A(amb|blu|brn|gry|grn|hzl|oth)\z/,
      "pid" => /\A\d{9}\z/,
      "cid" => /.+/
    }

    def count_passports_with_required_fields(input)
      documents = input.split("\n\n")

      documents.count { |document| validate_passport_required_fields(document) }
    end

    def validate_passports(input)
      documents = input.split("\n\n")

      documents.count do |document|
        validate_passport_required_fields(document) && validate_passport_values(document)
      end
    end

    def validate_single_field_value(key, value)
      value.match?(RULES[key])
    end

    private

    def validate_passport_required_fields(input)
      fields_with_values = input.split(/\s/)
      keys = fields_with_values.map { |el| el.split(":").first }

      REQUIRED_FIELDS.all? { |required_field| keys.include?(required_field) }
    end

    def validate_passport_values(input)
      fields_with_values = input.split(/\s/).map { |el| el.split(":") }.to_h

      fields_with_values.all? { |key, value| validate_single_field_value(key, value) }
    end
  end
end

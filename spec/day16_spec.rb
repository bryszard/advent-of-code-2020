RSpec.describe Day16 do
  let(:short_input) { File.read(File.expand_path("fixtures/day16-1.txt", __dir__)) }
  let(:short_input_2) { File.read(File.expand_path("fixtures/day16-3.txt", __dir__)) }
  let(:puzzle_input) { File.read(File.expand_path("fixtures/day16-2.txt", __dir__)) }

  describe ".count_invalid_values" do
    subject(:count_invalid_values) { described_class.count_invalid_values(input) }

    context "when short input" do
      let(:input) { short_input }

      it { is_expected.to eq(71) }
    end

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(25961) }
    end
  end

  describe ".decode_your_ticket" do
    subject(:decode_your_ticket) { described_class.decode_your_ticket(input) }

    context "when short input" do
      let(:input) { short_input_2 }

      it "returns keys with index in tickets" do
        is_expected.to eq(
          "class" => "12",
          "row" => "11",
          "seat" => "13"
        )
      end
    end
  end

  describe ".calculate_departure_fields" do
    subject(:calculate_departure_fields) { described_class.calculate_departure_fields(input) }

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(603409823791) }
    end
  end
end

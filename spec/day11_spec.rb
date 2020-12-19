RSpec.describe Day11 do
  let(:short_input) { File.read(File.expand_path("fixtures/older/day11-1.txt", __dir__)) }
  let(:puzzle_input) { File.read(File.expand_path("fixtures/older/day11-2.txt", __dir__)) }

  describe ".calculate_occupied_seats" do
    subject(:calculate_occupied_seats) { described_class.calculate_occupied_seats(input) }

    context "when first short input" do
      let(:input) { short_input }

      it { is_expected.to eq(37) }
    end

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(2489) }
    end
  end

  describe ".calculate_occupied_seats_alt" do
    subject(:calculate_occupied_seats_alt) { described_class.calculate_occupied_seats_alt(input) }

    context "when first short input" do
      let(:input) { short_input }

      it { is_expected.to eq(26) }
    end

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(2180) }
    end
  end
end

RSpec.describe Day11::Position do
  let(:described_object) { described_class.new(row, column, surroudings) }
  let(:surroudings) { input.split("\n").map(&:chars) }

  describe "#visible_adjacent_seats" do
    subject(:visible_adjacent_seats) { described_object.visible_adjacent_seats }

    context "when example 1" do
      let(:row) { 4 }
      let(:column) { 3 }
      let(:input) { File.read(File.expand_path("fixtures/day11-3.txt", __dir__)) }

      it { is_expected.to eq(["#", "#", "#", "#", "#", "#", "#", "#"]) }
    end

    context "when example 2" do
      let(:row) { 1 }
      let(:column) { 1 }
      let(:input) { File.read(File.expand_path("fixtures/day11-4.txt", __dir__)) }

      it { is_expected.to eq(["L"]) }
    end

    context "when example 3" do
      let(:row) { 3 }
      let(:column) { 3 }
      let(:input) { File.read(File.expand_path("fixtures/day11-5.txt", __dir__)) }

      it { is_expected.to eq([]) }
    end
  end
end

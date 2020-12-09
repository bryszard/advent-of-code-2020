RSpec.describe Day5 do
  let(:puzzle_input) { File.read(File.expand_path("fixtures/day5-1.txt", __dir__)) }

  describe ".calculate_seat_code" do
    subject(:calculate_seat_code) { described_class.calculate_seat_code(input) }

    context "example 1" do
      let(:input) { "FBFBBFFRLR" }

      it { is_expected.to eq(357) }
    end

    context "example 2" do
      let(:input) { "BFFFBBFRRR" }

      it { is_expected.to eq(567) }
    end

    context "example 3" do
      let(:input) { "FFFBBBFRRR" }

      it { is_expected.to eq(119) }
    end

    context "example 4" do
      let(:input) { "BBFFBBFRLL" }

      it { is_expected.to eq(820) }
    end
  end

  describe ".find_highest_code" do
    subject(:find_highest_code) { described_class.find_highest_code(input) }

    context "for puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(965) }
    end
  end

  describe ".find_missing_code" do
    subject(:find_missing_code) { described_class.find_missing_code(input) }

    context "for puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(524) }
    end
  end
end

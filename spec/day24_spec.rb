RSpec.describe Day24 do
  let(:short_input) { File.read(File.expand_path("fixtures/day24-1.txt", __dir__)) }
  let(:puzzle_input) { File.read(File.expand_path("fixtures/day24-2.txt", __dir__)) }

  describe ".count_black_tiles" do
    subject(:count_black_tiles) { described_class.count_black_tiles(input) }

    context "when example 1" do
      let(:input) { short_input }

      it { is_expected.to eq(10) }
    end

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(420) }
    end
  end

  describe ".living_art_state" do
    subject(:living_art_state) { described_class.living_art_state(input) }

    context "when example 1" do
      let(:input) { short_input }

      it { is_expected.to eq(2208) }
    end

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(4206) }
    end
  end
end

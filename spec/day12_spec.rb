RSpec.describe Day12 do
  let(:short_input) { File.read(File.expand_path("fixtures/day12-1.txt", __dir__)) }
  let(:puzzle_input) { File.read(File.expand_path("fixtures/day12-2.txt", __dir__)) }

  describe ".calculate_final_distance" do
    subject(:calculate_final_distance) { described_class.calculate_final_distance(input) }

    context "when first short input" do
      let(:input) { short_input }

      it { is_expected.to eq(25) }
    end

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(1457) }
    end
  end

  describe ".calculate_waypoint_distance" do
    subject(:calculate_waypoint_distance) { described_class.calculate_waypoint_distance(input) }

    context "when first short input" do
      let(:input) { short_input }

      it { is_expected.to eq(286) }
    end

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(106860) }
    end
  end
end

RSpec.describe Day12::InstructionsParser do
  let(:short_input) { File.read(File.expand_path("fixtures/day12-1.txt", __dir__)) }

  describe ".normalize" do
    subject(:normalize) { described_class.new(instructions).normalize }

    let(:instructions) { input.split("\n") }

    context "when first short input" do
      let(:input) { short_input }

      it "normalizes instructions" do
        expect(normalize.last).to eq("S11")
      end
    end
  end
end

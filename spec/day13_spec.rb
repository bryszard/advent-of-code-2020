RSpec.describe Day13 do
  let(:short_input) { File.read(File.expand_path("fixtures/older/day13-1.txt", __dir__)) }
  let(:puzzle_input) { File.read(File.expand_path("fixtures/older/day13-2.txt", __dir__)) }

  describe ".find_earliest_bus" do
    subject(:find_earliest_bus) { described_class.find_earliest_bus(input) }

    context "when first short input" do
      let(:input) { short_input }

      it { is_expected.to eq(295) }
    end

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(333) }
    end
  end

  describe ".find_perfect_timestamp" do
    subject(:find_perfect_timestamp) { described_class.find_perfect_timestamp(input) }

    context "when example 1" do
      let(:input) { "17,x,13,19" }

      it { is_expected.to eq(3417) }
    end

    context "when example 2" do
      let(:input) { "67,7,59,61" }

      it { is_expected.to eq(754018) }
    end

    context "when example 3" do
      let(:input) { "67,x,7,59,61" }

      it { is_expected.to eq(779210) }
    end

    context "when example 4" do
      let(:input) { "67,7,x,59,61" }

      it { is_expected.to eq(1261476) }
    end

    context "when example 5" do
      let(:input) { "1789,37,47,1889" }

      it { is_expected.to eq(1202161486) }
    end

    context "when first short input" do
      let(:input) { short_input.split("\n")[1] }

      it { is_expected.to eq(1068781) }
    end

    context "when puzzle input" do
      let(:input) { puzzle_input.split("\n")[1] }

      it { is_expected.to eq(690123192779524) }
    end
  end
end

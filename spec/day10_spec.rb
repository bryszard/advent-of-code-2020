RSpec.describe Day10 do
  let(:short_input_1) { File.read(File.expand_path("fixtures/day10-1.txt", __dir__)) }
  let(:short_input_2) { File.read(File.expand_path("fixtures/day10-2.txt", __dir__)) }
  let(:puzzle_input) { File.read(File.expand_path("fixtures/day10-3.txt", __dir__)) }

  describe ".calculate_jolt_differences" do
    subject(:calculate_jolt_differences) { described_class.calculate_jolt_differences(input) }

    context "when first short input" do
      let(:input) { short_input_1 }

      it { is_expected.to eq(35) }
    end

    context "when second short input" do
      let(:input) { short_input_2 }

      it { is_expected.to eq(220) }
    end

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(1885) }
    end
  end

  describe ".calculate_possible_arrangements" do
    subject(:calculate_possible_arrangements) { described_class.calculate_possible_arrangements(input) }

    context "when first short input" do
      let(:input) { short_input_1 }

      it { is_expected.to eq(8) }
    end

    context "when second short input" do
      let(:input) { short_input_2 }

      it { is_expected.to eq(19208) }
    end

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(2024782584832) }
    end
  end
end

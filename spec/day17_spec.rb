RSpec.describe Day17_1 do
  let(:short_input) { File.read(File.expand_path("fixtures/older/day17-1.txt", __dir__)) }
  let(:puzzle_input) { File.read(File.expand_path("fixtures/older/day17-2.txt", __dir__)) }

  describe ".simulate_six_cycles" do
    subject(:simulate_six_cycles) { described_class.simulate_six_cycles(input) }

    context "when short input" do
      let(:input) { short_input }

      it { is_expected.to eq(112) }
    end

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(240) }
    end
  end
end

RSpec.describe Day17_2 do
  let(:short_input) { File.read(File.expand_path("fixtures/day17-1.txt", __dir__)) }
  let(:puzzle_input) { File.read(File.expand_path("fixtures/day17-2.txt", __dir__)) }

  describe ".simulate_six_cycles" do
    subject(:simulate_six_cycles) { described_class.simulate_six_cycles(input) }

    context "when short input" do
      let(:input) { short_input }

      it { is_expected.to eq(848) }
    end

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(1180) }
    end
  end
end

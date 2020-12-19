RSpec.describe Day7 do
  let(:short_input) { File.read(File.expand_path("fixtures/older/day7-1.txt", __dir__)) }
  let(:puzzle_input) { File.read(File.expand_path("fixtures/older/day7-2.txt", __dir__)) }
  let(:additional_short_input) { File.read(File.expand_path("fixtures/older/day7-3.txt", __dir__)) }

  describe ".calculate_outermost_options" do
    subject(:calculate) { described_class.calculate_outermost_options(input) }

    context "when short input" do
      let(:input) { short_input }

      it { is_expected.to eq(4) }
    end

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(233) }
    end
  end

  describe ".calculate_inner_bags" do
    subject(:calculate) { described_class.calculate_inner_bags(input) }

    context "when short input" do
      let(:input) { short_input }

      it { is_expected.to eq(32) }
    end

    context "when another short input" do
      let(:input) { additional_short_input }

      it { is_expected.to eq(126) }
    end

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(421550) }
    end
  end
end

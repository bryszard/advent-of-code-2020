RSpec.describe Day14 do
  let(:short_input) { File.read(File.expand_path("fixtures/day14-1.txt", __dir__)) }
  let(:puzzle_input) { File.read(File.expand_path("fixtures/day14-2.txt", __dir__)) }

  describe ".sum_remaining_values" do
    subject(:sum_remaining_values) { described_class.sum_remaining_values(input) }

    context "when first short input" do
      let(:input) { short_input }

      it { is_expected.to eq(165) }
    end

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(8471403462063) }
    end
  end

  describe ".sum_remaining_values_part_2" do
    subject(:sum_remaining_values_part_2) { described_class.sum_remaining_values_part_2(input) }

    let(:short_input) { File.read(File.expand_path("fixtures/day14-3.txt", __dir__)) }

    context "when first short input" do
      let(:input) { short_input }

      it { is_expected.to eq(208) }
    end

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(2667858637669) }
    end
  end
end

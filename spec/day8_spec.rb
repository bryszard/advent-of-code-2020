RSpec.describe Day8 do
  let(:short_input) { File.read(File.expand_path("fixtures/day8-1.txt", __dir__)) }
  let(:puzzle_input) { File.read(File.expand_path("fixtures/day8-2.txt", __dir__)) }

  describe ".acc_value_before_infinite_loop" do
    subject(:calculate) { described_class.acc_value_before_infinite_loop(input) }

    context "when short input" do
      let(:input) { short_input }

      it { is_expected.to eq(5) }
    end

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(1337) }
    end
  end

  describe ".acc_value_with_loop_fixes" do
    subject(:calculate) { described_class.acc_value_with_loop_fixes(input) }

    context "when short input" do
      let(:input) { short_input }

      it { is_expected.to eq(8) }
    end

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(1358) }
    end
  end
end

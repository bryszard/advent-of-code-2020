RSpec.describe Day18_1 do
  let(:puzzle_input) { File.read(File.expand_path("fixtures/older/day18-1.txt", __dir__)) }

  describe ".calc_alt_math" do
    subject(:calc_alt_math) { described_class.calc_alt_math(input) }

    context "when example 1" do
      let(:input) { "1 + 2 * 3 + 4 * 5 + 6" }

      it { is_expected.to eq(71) }
    end

    context "when example 2" do
      let(:input) { "1 + (2 * 3) + (4 * (5 + 6))" }

      it { is_expected.to eq(51) }
    end

    context "when example 3" do
      let(:input) { "2 * 3 + (4 * 5)" }

      it { is_expected.to eq(26) }
    end

    context "when example 4" do
      let(:input) { "5 + (8 * 3 + 9 + 3 * 4 * 3)" }

      it { is_expected.to eq(437) }
    end

    context "when example 5" do
      let(:input) { "5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))" }

      it { is_expected.to eq(12240) }
    end

    context "when example 6" do
      let(:input) { "((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2" }

      it { is_expected.to eq(13632) }
    end
  end

  describe "sum_all_results" do
    subject(:sum_all_results) { described_class.sum_all_results(input) }

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(131076645626) }
    end
  end
end

RSpec.describe Day18_2 do
  let(:puzzle_input) { File.read(File.expand_path("fixtures/day18-1.txt", __dir__)) }

  describe ".calc_alt_math" do
    subject(:calc_alt_math) { described_class.calc_alt_math(input) }

    context "when example 1" do
      let(:input) { "1 + 2 * 3 + 4 * 5 + 6" }

      it { is_expected.to eq(231) }
    end

    context "when example 2" do
      let(:input) { "1 + (2 * 3) + (4 * (5 + 6))" }

      it { is_expected.to eq(51) }
    end

    context "when example 3" do
      let(:input) { "2 * 3 + (4 * 5)" }

      it { is_expected.to eq(46) }
    end

    context "when example 4" do
      let(:input) { "5 + (8 * 3 + 9 + 3 * 4 * 3)" }

      it { is_expected.to eq(1445) }
    end

    context "when example 5" do
      let(:input) { "5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))" }

      it { is_expected.to eq(669060) }
    end

    context "when example 6" do
      let(:input) { "((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2" }

      it { is_expected.to eq(23340) }
    end
  end

  describe "sum_all_results" do
    subject(:sum_all_results) { described_class.sum_all_results(input) }

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(109418509151782) }
    end
  end
end

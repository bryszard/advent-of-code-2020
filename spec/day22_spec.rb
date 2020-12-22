RSpec.describe Day22_2 do
  let(:short_input) { File.read(File.expand_path("fixtures/day22-1.txt", __dir__)) }
  let(:short_input_2) { File.read(File.expand_path("fixtures/day22-3.txt", __dir__)) }
  let(:puzzle_input) { File.read(File.expand_path("fixtures/day22-2.txt", __dir__)) }

  describe ".calculate_game_score" do
    subject(:calculate_game_score) { described_class.calculate_game_score(input) }

    context "when example 1" do
      let(:input) { short_input }

      it { is_expected.to eq(291) }
    end

    context "when example 2" do
      let(:input) { short_input_2 }

      it { is_expected.to eq(369) }
    end

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(33212) }
    end
  end
end

RSpec.describe Day22_1 do
  let(:short_input) { File.read(File.expand_path("fixtures/day22-1.txt", __dir__)) }
  let(:puzzle_input) { File.read(File.expand_path("fixtures/day22-2.txt", __dir__)) }

  describe ".calculate_game_score" do
    subject(:calculate_game_score) { described_class.calculate_game_score(input) }

    context "when example 1" do
      let(:input) { short_input }

      it { is_expected.to eq(306) }
    end

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(31957) }
    end
  end
end

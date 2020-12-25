RSpec.describe Day23_3 do
  describe ".play_cups_game" do
    subject(:play_cups_game) { described_class.play_cups_game(input) }

    context "when example 1" do
      let(:input) { "389125467" }

      it { is_expected.to eq(149245887792) }
    end

    context "when puzzle input" do
      let(:input) { "284573961" }

      it { is_expected.to eq(166298218695) }
    end
  end
end

RSpec.describe Day23_1 do
  describe ".play_cups_game" do
    subject(:play_cups_game) { described_class.play_cups_game(input) }

    context "when example 1" do
      let(:input) { "389125467" }

      it { is_expected.to eq("67384529") }
    end

    context "when puzzle input" do
      let(:input) { "284573961" }

      it { is_expected.to eq("26354798") }
    end
  end
end

RSpec.describe Day15 do
  describe ".find_spoken_twentytwenty" do
    subject(:find_spoken_twentytwenty) { described_class.find_spoken_twentytwenty(input) }

    context "when example 1" do
      let(:input) { [0, 3, 6] }

      it { is_expected.to eq(436) }
    end

    context "when example 2" do
      let(:input) { [1, 3, 2] }

      it { is_expected.to eq(1) }
    end

    context "when example 3" do
      let(:input) { [2, 1, 3] }

      it { is_expected.to eq(10) }
    end

    context "when example 4" do
      let(:input) { [1, 2, 3] }

      it { is_expected.to eq(27) }
    end

    context "when example 5" do
      let(:input) { [2, 3, 1] }

      it { is_expected.to eq(78) }
    end

    context "when example 6" do
      let(:input) { [3, 2, 1] }

      it { is_expected.to eq(438) }
    end

    context "when example 6" do
      let(:input) { [3, 1, 2] }

      it { is_expected.to eq(1836) }
    end

    context "when puzzle input" do
      let(:input) { [1, 2, 16, 19, 18, 0] }

      it { is_expected.to eq(536) }
    end
  end

  # Runs slowly
  describe ".find_spoken_thirtymln" do
    subject(:find_spoken_thirtymln) { described_class.find_spoken_thirtymln(input) }

    context "when example 1" do
      let(:input) { [0, 3, 6] }

      it { is_expected.to eq(175594) }
    end

    context "when example 2" do
      let(:input) { [1, 3, 2] }

      it { is_expected.to eq(2578) }
    end

    context "when example 3" do
      let(:input) { [2, 1, 3] }

      it { is_expected.to eq(3544142) }
    end

    context "when example 4" do
      let(:input) { [1, 2, 3] }

      it { is_expected.to eq(261214) }
    end

    context "when example 5" do
      let(:input) { [2, 3, 1] }

      it { is_expected.to eq(6895259) }
    end

    context "when example 6" do
      let(:input) { [3, 2, 1] }

      it { is_expected.to eq(18) }
    end

    context "when example 6" do
      let(:input) { [3, 1, 2] }

      it { is_expected.to eq(362) }
    end

    context "when puzzle input" do
      let(:input) { [1, 2, 16, 19, 18, 0] }

      it { is_expected.to eq(24065124) }
    end
  end
end

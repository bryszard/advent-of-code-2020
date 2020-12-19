RSpec.describe Day19 do
  let(:short_input_1) { File.read(File.expand_path("fixtures/day19-1.txt", __dir__)) }
  let(:short_input_2) { File.read(File.expand_path("fixtures/day19-2.txt", __dir__)) }
  let(:short_input_3) { File.read(File.expand_path("fixtures/day19-3.txt", __dir__)) }
  let(:short_input_4) { File.read(File.expand_path("fixtures/day19-6.txt", __dir__)) }
  let(:puzzle_input) { File.read(File.expand_path("fixtures/day19-4.txt", __dir__)) }

  describe ".count_valid_messages" do
    subject(:count_valid_messages) { described_class.count_valid_messages(input) }

    context "when example 1" do
      let(:input) { short_input_1 }

      it { is_expected.to eq(2) }
    end

    context "when example 2" do
      let(:input) { short_input_2 }

      it { is_expected.to eq(8) }
    end

    context "when example 3" do
      let(:input) { short_input_3 }

      it { is_expected.to eq(2) }
    end

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(120) }
    end

    context "when puzzle input 2" do
      subject(:count_valid_messages) { described_class.count_valid_messages(input, true) }
      let(:input) { puzzle_input }

      it { is_expected.to eq(350) }
    end

    context "when example 4" do
      let(:input) { short_input_4 }

      it { is_expected.to eq(3) }

      context "when antiloop on" do
        subject(:count_valid_messages) { described_class.count_valid_messages(input, true) }

        it { is_expected.to eq(12) }
      end
    end
  end
end

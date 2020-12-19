RSpec.describe Day9 do
  let(:short_input) { File.read(File.expand_path("fixtures/older/day9-1.txt", __dir__)) }
  let(:puzzle_input) { File.read(File.expand_path("fixtures/older/day9-2.txt", __dir__)) }

  describe ".find_invalid_encoding" do
    subject(:find_invalid) { described_class.find_invalid_encoding(input, preamble_size) }

    context "when short preamble and input" do
      let(:input) { short_input }
      let(:preamble_size) { 5 }

      it { is_expected.to eq(127) }
    end

    context "when 25 long preamble and puzzle input" do
      let(:input) { puzzle_input }
      let(:preamble_size) { 25 }

      it { is_expected.to eq(776203571) }
    end
  end

  describe ".find_encryption_weakness" do
    subject(:find_encryption_weakness) { described_class.find_encryption_weakness(input, preamble_size) }

    context "when short preamble and input" do
      let(:input) { short_input }
      let(:preamble_size) { 5 }

      it { is_expected.to eq(62) }
    end

    context "when 25 long preamble and puzzle input" do
      let(:input) { puzzle_input }
      let(:preamble_size) { 25 }

      it { is_expected.to eq(104800569) }
    end
  end

  describe ".is_valid?" do
    subject(:is_valid?) { described_class.is_valid?(number, preamble) }

    let(:preamble) { base_range }
    let(:base_range) { (1..25).to_a }

    context "when 26" do
      let(:number) { 26 }

      it { is_expected.to be_truthy }
    end

    context "when 49" do
      let(:number) { 49 }

      it { is_expected.to be_truthy }
    end

    context "when 100" do
      let(:number) { 100 }

      it { is_expected.to be_falsey }
    end

    context "when 50" do
      let(:number) { 50 }

      it { is_expected.to be_falsey }
    end

    context "with different preamble" do
      let(:preamble) { (1..19).to_a + (21..25).to_a + [45] }

      context "when 26" do
        let(:number) { 26 }

        it { is_expected.to be_truthy }
      end

      context "when 65" do
        let(:number) { 65 }

        it { is_expected.to be_falsey }
      end

      context "when 64" do
        let(:number) { 64 }

        it { is_expected.to be_truthy }
      end

      context "when 66" do
        let(:number) { 66 }

        it { is_expected.to be_truthy }
      end
    end
  end
end

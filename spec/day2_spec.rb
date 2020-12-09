RSpec.describe Day2 do
  let(:short_input) do
    "1-3 a: abcde\n" \
    "1-3 b: cdefg\n" \
    "2-9 c: ccccccccc"
  end
  let(:puzzle_input) { File.read(File.expand_path("fixtures/day2-1.txt", __dir__)) }

  describe ".count_valid" do
    subject(:count_valid) { described_class.count_valid(input) }

    context "when short example input" do
      let(:input) { short_input }

      it "returns number of correct passwords" do
        expect(count_valid).to eq(2)
      end
    end

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it "returns number of correct passwords" do
        expect(count_valid).to eq(636)
      end
    end
  end

  describe ".count_valid_alt" do
    subject(:count_valid_alt) { described_class.count_valid_alt(input) }

    context "when short example input" do
      let(:input) { short_input }

      it "returns number of correct passwords" do
        expect(count_valid_alt).to eq(1)
      end
    end

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it "returns number of correct passwords" do
        expect(count_valid_alt).to eq(588)
      end
    end
  end
end

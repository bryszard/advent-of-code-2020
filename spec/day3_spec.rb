RSpec.describe Day3 do
  let(:short_input) { File.read(File.expand_path("fixtures/day3-1.txt", __dir__)) }
  let(:puzzle_input) { File.read(File.expand_path("fixtures/day3-2.txt", __dir__)) }

  describe ".count_trees" do
    subject(:count_trees) { described_class.count_trees(input) }

    context "when short example input" do
      let(:input) { short_input }

      it "returns number of trees" do
        expect(count_trees).to eq(7)
      end
    end

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it "returns number of trees" do
        expect(count_trees).to eq(282)
      end
    end
  end

  describe ".combine_five_paths" do
    subject(:combine_five_paths) { described_class.combine_five_paths(input) }

    context "when short example input" do
      let(:input) { short_input }

      it "returns number of trees" do
        expect(combine_five_paths).to eq(336)
      end
    end

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it "returns number of trees" do
        expect(combine_five_paths).to eq(958815792)
      end
    end
  end
end

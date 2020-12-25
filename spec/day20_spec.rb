RSpec.describe Day20 do
  let(:short_input) { File.read(File.expand_path("fixtures/day20-1.txt", __dir__)) }
  let(:puzzle_input) { File.read(File.expand_path("fixtures/day20-2.txt", __dir__)) }

  describe ".calculate_corners" do
    subject(:calculate_corners) { described_class.calculate_corners(input) }

    context "when example 1" do
      let(:input) { short_input }

      it { is_expected.to eq(20899048083289) }
    end

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(79412832860579) }
    end
  end

  describe ".calculate_non_monster_hashes" do
    subject(:calculate_non_monster_hashes) { described_class.calculate_non_monster_hashes(input) }

    context "when example 1" do
      let(:input) { short_input }

      it { is_expected.to eq(273) }
    end

    context "when puzzle input" do
      let(:puzzle_input) { File.read(File.expand_path("fixtures/day20-2.txt", __dir__)) }
      let(:input) { puzzle_input }

      it { is_expected.to eq(2155) }
    end

    context "when puzzle input 2" do
      let(:puzzle_input) { File.read(File.expand_path("fixtures/day20-4.txt", __dir__)) }
      let(:input) { puzzle_input }

      it { is_expected.to eq(2304) }
    end
  end

  describe Day20::MonsterFinder do
    let(:described_object) { described_class.new(image) }
    let(:image) { File.read(File.expand_path("fixtures/day20-3.txt", __dir__)) }

    describe "#call" do
      subject(:find_monsters) { described_object.call }

      it { is_expected.to eq(2) }

      context "when different image" do
        let(:image) { File.read(File.expand_path("fixtures/day20-5.txt", __dir__)) }

        it { is_expected.to eq(25) }
      end
    end
  end
end

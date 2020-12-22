RSpec.describe Day21 do
  let(:short_input) { File.read(File.expand_path("fixtures/day21-1.txt", __dir__)) }
  let(:puzzle_input) { File.read(File.expand_path("fixtures/day21-2.txt", __dir__)) }

  describe ".count_nonallergic_occurences" do
    subject(:count_nonallergic_occurences) { described_class.count_nonallergic_occurences(input) }

    context "when example 1" do
      let(:input) { short_input }

      it { is_expected.to eq(5) }
    end

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(1815) }
    end
  end

  describe ".canonical_dangerous_list" do
    subject(:canonical_dangerous_list) { described_class.canonical_dangerous_list(input) }

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq("kllgt,jrnqx,ljvx,zxstb,gnbxs,mhtc,hfdxb,hbfnkq") }
    end
  end
end

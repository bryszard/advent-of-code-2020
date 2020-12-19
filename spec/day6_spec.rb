RSpec.describe Day6 do
  let(:short_input) { File.read(File.expand_path("fixtures/older/day6-1.txt", __dir__)) }
  let(:puzzle_input) { File.read(File.expand_path("fixtures/older/day6-2.txt", __dir__)) }

  describe ".count_group_answers_1" do
    subject(:count_group_answers_1) { described_class.count_group_answers_1(input) }

    context "short input" do
      let(:input) { short_input }

      it { is_expected.to eq(11) }
    end

    context "puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(6542) }
    end
  end

  describe ".count_group_answers_2" do
    subject(:count_group_answers_2) { described_class.count_group_answers_2(input) }

    context "short input" do
      let(:input) { short_input }

      it { is_expected.to eq(6) }
    end

    context "puzzle input" do
      let(:input) { puzzle_input }

      it { is_expected.to eq(3299) }
    end
  end

  describe ".count_all_questions" do
    subject(:count_all_questions) { described_class.count_all_questions(input) }

    context "example 1" do
      let(:input) do
        %Q(
          abcx
          abcy
          abcz
        ).delete(" ")
      end

      it { is_expected.to eq(6) }
    end
  end
end

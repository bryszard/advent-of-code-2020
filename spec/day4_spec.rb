RSpec.describe Day4 do
  let(:short_input) { File.read(File.expand_path("fixtures/day4-1.txt", __dir__)) }
  let(:puzzle_input) { File.read(File.expand_path("fixtures/day4-2.txt", __dir__)) }

  describe ".count_passports_with_required_fields" do
    subject(:count_passports_with_required_fields) { described_class.count_passports_with_required_fields(input) }

    context "when short example input" do
      let(:input) { short_input }

      it "returns number of valid passports" do
        expect(count_passports_with_required_fields).to eq(2)
      end
    end

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it "returns number of trees" do
        expect(count_passports_with_required_fields).to eq(200)
      end
    end
  end

  describe ".validate_passports" do
    subject(:validate_passports) { described_class.validate_passports(input) }

    context "when short example input" do
      let(:input) { short_input }

      it "returns number of valid passports" do
        expect(validate_passports).to eq(2)
      end
    end

    context "when puzzle input" do
      let(:input) { puzzle_input }

      it "returns number of trees" do
        expect(validate_passports).to eq(116)
      end
    end
  end

  describe ".validate_single_field_value" do
    subject(:validate_single_field_value) { described_class.validate_single_field_value(key, value) }

    context "byr" do
      let(:key) { "byr" }

      context "valid" do
        let(:value) { "2002" }

        it { is_expected.to be_truthy }
      end

      context "invalid" do
        let(:value) { "2003" }

        it { is_expected.to be_falsey }
      end
    end

    context "hgt" do
      let(:key) { "hgt" }

      context "valid" do
        context "60in" do
          let(:value) { "60in" }

          it { is_expected.to be_truthy }
        end

        context "190cm" do
          let(:value) { "190cm" }

          it { is_expected.to be_truthy }
        end
      end

      context "invalid" do
        context "190in" do
          let(:value) { "190in" }

          it { is_expected.to be_falsey }
        end

        context "190" do
          let(:value) { "190" }

          it { is_expected.to be_falsey }
        end
      end
    end

    context "hcl" do
      let(:key) { "hcl" }

      context "valid" do
        context "#123abc" do
          let(:value) { "#123abc" }

          it { is_expected.to be_truthy }
        end
      end

      context "invalid" do
        context "#123abz" do
          let(:value) { "#123abz" }

          it { is_expected.to be_falsey }
        end

        context "123abc" do
          let(:value) { "123abc" }

          it { is_expected.to be_falsey }
        end
      end
    end

    context "ecl" do
      let(:key) { "ecl" }

      context "valid" do
        context "brn" do
          let(:value) { "brn" }

          it { is_expected.to be_truthy }
        end
      end

      context "invalid" do
        context "wat" do
          let(:value) { "wat" }

          it { is_expected.to be_falsey }
        end
      end
    end

    context "pid" do
      let(:key) { "pid" }

      context "valid" do
        context "000000001" do
          let(:value) { "000000001" }

          it { is_expected.to be_truthy }
        end
      end

      context "invalid" do
        context "0123456789" do
          let(:value) { "0123456789" }

          it { is_expected.to be_falsey }
        end
      end
    end
  end
end

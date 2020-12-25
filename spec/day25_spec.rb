RSpec.describe Day25 do
  describe ".find_encryption_key" do
    subject(:find_encryption_key) do
      described_class.find_encryption_key(card_public_key, door_public_key)
    end

    context "when example 1" do
      let(:card_public_key) { 5764801 }
      let(:door_public_key) { 17807724 }

      it { is_expected.to eq(14897079) }
    end

    context "when puzzle input" do
      let(:card_public_key) { 3248366 }
      let(:door_public_key) { 4738476 }

      it { is_expected.to eq(18293391) }
    end
  end
end

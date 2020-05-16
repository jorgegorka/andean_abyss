# frozen_string_literal: true

require 'rails_helper'

describe Resources::GovtForces do
  let(:govt_forces) { described_class.new }

  describe '#add' do
    before { govt_forces.add(force, 5) }

    context 'when force is a troop' do
      let(:force) { TROOPS }

      it { expect(govt_forces.troops.size).to eq(5) }
    end

    context 'when force is a police' do
      let(:force) { POLICE }

      it { expect(govt_forces.police.size).to eq(5) }
    end

    context 'when force is a base' do
      let(:force) { BASES }

      it { expect(govt_forces.bases.size).to eq(5) }
    end
  end

  describe '#remove' do
    before do
      govt_forces.add(force, 5)
    end

    context 'when force is troops' do
      let(:force) { TROOPS }

      it { expect { govt_forces.remove(TROOPS, 3) }.to change { govt_forces.troops.size }.from(5).to(2) }
    end

    context 'when force is police' do
      let(:force) { POLICE }

      it { expect { govt_forces.remove(POLICE, 3) }.to change { govt_forces.police.size }.from(5).to(2) }
    end

    context 'when force is a base' do
      let(:force) { BASES }

      it { expect { govt_forces.remove(BASES, 3) }.to change { govt_forces.bases.size }.from(5).to(2) }
    end
  end
end

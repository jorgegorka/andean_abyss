# frozen_string_literal: true

require 'rails_helper'

describe Resources::Insurgents do
  let(:insurgents) { described_class.new }

  describe '#add' do
    before { insurgents.add(force, 5) }

    context 'when force is a guerrilla' do
      let(:force) { GUERRILLAS }

      it { expect(insurgents.hidden_guerrillas.size).to eq(5) }
    end

    context 'when force is a base' do
      let(:force) { BASES }

      it { expect(insurgents.bases.size).to eq(5) }
    end
  end

  describe '#activate_guerrilla' do
    before { insurgents.add(GUERRILLAS, 3) }

    it { expect { insurgents.activate_guerrilla }.to change { insurgents.active_guerrillas.size }.from(0).to(1) }

    it { expect { insurgents.activate_guerrilla }.to change { insurgents.hidden_guerrillas.size }.from(3).to(2) }
  end

  describe '#hide_guerrilla' do
    before do
      insurgents.add(GUERRILLAS, 3)
      insurgents.activate_guerrilla
      insurgents.activate_guerrilla
    end

    it { expect { insurgents.hide_guerrilla }.to change { insurgents.active_guerrillas.size }.from(2).to(1) }

    it { expect { insurgents.hide_guerrilla }.to change { insurgents.hidden_guerrillas.size }.from(1).to(2) }
  end

  describe '#remove' do
    before do
      insurgents.add(force, 5)
    end

    context 'when force is a guerrilla' do
      let(:force) { GUERRILLAS }

      before { 3.times { insurgents.activate_guerrilla } }

      context 'when remove only active' do
        it { expect { insurgents.remove(GUERRILLAS, 2) }.to change { insurgents.active_guerrillas.size }.from(3).to(1) }

        it { expect { insurgents.remove(GUERRILLAS, 2) }.to change { insurgents.hidden_guerrillas.size }.by(0) }
      end

      context 'when remove all guerrillas' do
        it { expect { insurgents.remove(GUERRILLAS, 4, true) }.to change { insurgents.active_guerrillas.size }.from(3).to(0) }

        it { expect { insurgents.remove(GUERRILLAS, 4, true) }.to change { insurgents.hidden_guerrillas.size }.from(2).to(1) }
      end
    end

    context 'when force is a base' do
      let(:force) { BASES }

      it { expect { insurgents.remove(BASES, 3) }.to change { insurgents.bases.size }.from(5).to(2) }
    end
  end
end

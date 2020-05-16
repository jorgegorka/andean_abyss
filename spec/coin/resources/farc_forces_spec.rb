# frozen_string_literal: true

require 'rails_helper'

describe Resources::FarcForces do
  let(:farc_forces) { described_class.new }

  describe '#activate_guerrilla' do
    before { farc_forces.add(GUERRILLAS, 6) }

    it { expect { farc_forces.activate_guerrilla }.to change { farc_forces.active_guerrillas.size }.from(0).to(1) }
    it { expect { farc_forces.activate_guerrilla }.to change { farc_forces.hidden_guerrillas.size }.from(6).to(5) }
  end

  describe '#remove' do
    let(:resource) { BASES }
    let(:amount) { 2 }
    let(:include_hidden) { false }

    subject { farc_forces.remove(resource, amount, include_hidden) }

    context 'when resource is a base' do
      before { farc_forces.add(BASES, 3) }

      it { expect { farc_forces.remove(resource, amount) }.to change { farc_forces.bases.size }.from(3).to(1) }
    end

    context 'when resource is a guerrilla' do
      let(:resource) { GUERRILLAS }
      let(:amount) { 3 }

      before do
        farc_forces.add(GUERRILLAS, 3)
        farc_forces.activate_guerrilla
        farc_forces.activate_guerrilla
      end

      context 'when hidden guerrillas are not included' do
        it { expect { subject }.to change { farc_forces.active_guerrillas.size }.from(2).to(0) }

        it { expect { subject }.to_not change { farc_forces.hidden_guerrillas.size } }
      end

      context 'when hidden guerrillas are included' do
        let(:include_hidden) { true }

        it { expect { subject }.to change { farc_forces.active_guerrillas.size }.from(2).to(0) }

        it { expect { subject }.to change { farc_forces.hidden_guerrillas.size }.from(1).to(0) }
      end
    end
  end
end

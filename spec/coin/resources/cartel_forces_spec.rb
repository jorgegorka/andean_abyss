# frozen_string_literal: true

require 'rails_helper'

describe Resources::CartelForces do
  let(:cartel_forces) { described_class.new }

  describe '#activate_guerrilla' do
    before { cartel_forces.add(GUERRILLAS, 6) }

    it { expect { cartel_forces.activate_guerrilla }.to change { cartel_forces.active_guerrillas.size }.from(0).to(1) }
    it { expect { cartel_forces.activate_guerrilla }.to change { cartel_forces.hidden_guerrillas.size }.from(6).to(5) }
  end

  describe '#remove' do
    let(:resource) { BASES }
    let(:amount) { 2 }

    subject { cartel_forces.remove(resource, amount) }

    context 'when resource is a base' do
      before { cartel_forces.add(BASES, 3) }

      it { expect { cartel_forces.remove(resource, amount) }.to change { cartel_forces.bases.size }.from(3).to(1) }
    end

    context 'when resource is a guerrilla' do
      let(:resource) { GUERRILLAS }

      before do
        cartel_forces.add(GUERRILLAS, 3)
        cartel_forces.activate_guerrilla
        cartel_forces.activate_guerrilla
      end

      it { expect { cartel_forces.remove(resource, amount) }.to change { cartel_forces.active_guerrillas.size }.from(2).to(0) }
    end
  end
end

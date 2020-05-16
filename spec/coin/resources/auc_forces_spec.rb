# frozen_string_literal: true

require 'rails_helper'

describe Resources::AucForces do
  let(:auc_forces) { described_class.new }

  describe '#activate_guerrilla' do
    before { auc_forces.add(GUERRILLAS, 6) }

    it { expect { auc_forces.activate_guerrilla }.to change { auc_forces.active_guerrillas.size }.from(0).to(1) }
    it { expect { auc_forces.activate_guerrilla }.to change { auc_forces.hidden_guerrillas.size }.from(6).to(5) }
  end

  describe '#remove' do
    let(:resource) { BASES }
    let(:amount) { 2 }
    let(:include_hidden) { false }

    subject { auc_forces.remove(resource, amount, include_hidden) }

    context 'when resource is a base' do
      before { auc_forces.add(BASES, 3) }

      it { expect { auc_forces.remove(resource, amount) }.to change { auc_forces.bases.size }.from(3).to(1) }
    end

    context 'when resource is a guerrilla' do
      let(:resource) { GUERRILLAS }
      let(:amount) { 3 }

      before do
        auc_forces.add(GUERRILLAS, 3)
        auc_forces.activate_guerrilla
        auc_forces.activate_guerrilla
      end

      context 'when hidden guerrillas are not included' do
        it { expect { subject }.to change { auc_forces.active_guerrillas.size }.from(2).to(0) }

        it { expect { subject }.to_not change { auc_forces.hidden_guerrillas.size } }
      end

      context 'when hidden guerrillas are included' do
        let(:include_hidden) { true }

        it { expect { subject }.to change { auc_forces.active_guerrillas.size }.from(2).to(0) }

        it { expect { subject }.to change { auc_forces.hidden_guerrillas.size }.from(1).to(0) }
      end
    end
  end
end

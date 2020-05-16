# frozen_string_literal: true

require 'rails_helper'

describe Ai::MoveForces do
  let(:origin) { build(:city) }
  let(:destination) { build(:province) }
  let(:resources) { { faction: GOVT_FACTION, force: POLICE, qty: 5, include_hidden: false } }
  let(:move) { described_class.new(origin, destination, resources) }

  describe '#perform' do
    subject { move.perform }

    before do
      origin.add_forces_to(GOVT_FACTION, POLICE, 8)
    end

    it { expect { subject }.to change { origin.govt_police_total }.from(8).to(3) }

    it { expect { subject }.to change { destination.govt_police_total }.from(0).to(5) }

    context 'status of guerrilla is preserved' do
      let(:resources) { { faction: FARC_FACTION, force: GUERRILLAS, qty: 5, include_hidden: true } }

      before do
        origin.add_forces_to(FARC_FACTION, GUERRILLAS, 5)
        origin.activate_guerrilla(FARC_FACTION)
        origin.activate_guerrilla(FARC_FACTION)
      end

      it { expect { subject }.to change { origin.farc_active_guerrillas_total }.from(2).to(0) }

      it { expect { subject }.to change { origin.farc_hidden_guerrillas_total }.from(3).to(0) }

      it { expect { subject }.to change { destination.farc_active_guerrillas_total }.from(0).to(2) }

      it { expect { subject }.to change { destination.farc_hidden_guerrillas_total }.from(0).to(3) }
    end

    context 'shipments are preserved' do
      let(:resources) { { faction: CARTEL_FACTION, force: GUERRILLAS, qty: 2, include_hidden: true } }

      before do
        destination.add_forces_to(AUC_FACTION, GUERRILLAS, 6)
        origin.add_forces_to(CARTEL_FACTION, GUERRILLAS, 2)
        origin.forces[CARTEL_FACTION].guerrillas.first.add_shipment
      end

      it { expect { subject }.to change { origin.cartel_guerrillas_total }.from(2).to(0) }

      it { expect { subject }.to change { origin.cartel_guerrillas_with_shipments_total }.from(1).to(0) }

      it { expect { subject }.to change { origin.forces_total }.from(10).to(8) }

      it { expect { subject }.to change { destination.cartel_guerrillas_total }.from(0).to(2) }

      it { expect { subject }.to change { destination.cartel_guerrillas_with_shipments_total }.from(0).to(1) }

      it { expect { subject }.to change { destination.forces_total }.from(6).to(8) }
    end
  end
end

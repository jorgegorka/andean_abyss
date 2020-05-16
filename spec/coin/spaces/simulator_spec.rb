# frozen_string_literal: true

require 'rails_helper'

describe Spaces::Simulator do
  let(:location) { build(:city) }
  let(:actions) do
    [
      { name: GOVT_FACTION, force: TROOPS, added: 3 },
      { name: GOVT_FACTION, force: POLICE, added: 6 },
      { name: CARTEL_FACTION, force: GUERRILLAS, added: 3 },
      { name: FARC_FACTION, force: GUERRILLAS, removed: 2 }
    ]
  end
  let(:simulator) { described_class.new(location, actions) }

  before do
    location.add_forces_to(FARC_FACTION, GUERRILLAS, 5)
    location.add_forces_to(GOVT_FACTION, POLICE, 1)
    3.times { location.activate_guerrilla(FARC_FACTION) }
  end

  describe '#perform' do
    subject { simulator.perform }

    it { expect(subject.farc_guerrillas_total).to eq(3) }
    it { expect(subject.farc_active_guerrillas_total).to eq(1) }
    it { expect(subject.govt_troops_total).to eq(3) }
    it { expect(subject.govt_police_total).to eq(7) }
    it { expect(subject.cartel_guerrillas_total).to eq(3) }
    it { expect(subject.control).to eq(CONTROL_GOVT) }

    it { expect(location.farc_guerrillas_total).to eq(5) }
    it { expect(location.farc_active_guerrillas_total).to eq(3) }
    it { expect(location.govt_troops_total).to eq(0) }
    it { expect(location.govt_police_total).to eq(1) }
    it { expect(location.cartel_guerrillas_total).to eq(0) }
    it { expect(location.control).to eq(CONTROL_FARC) }

    context 'when there are shipments' do
      let(:actions) { [{ name: FARC_FACTION, force: GUERRILLAS, added: :shipment }] }

      it { expect(subject.farc_shipments_total).to eq(1) }
    end
  end
end

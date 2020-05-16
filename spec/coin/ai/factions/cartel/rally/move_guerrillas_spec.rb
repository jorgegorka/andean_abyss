# frozen_string_literal: true

require 'rails_helper'

describe Ai::Factions::Cartel::Rally::MoveGuerrillas do
  let(:origin1) { build(:city) }
  let(:origin2) { build(:province) }
  let(:destination) { build(:province) }
  let(:origins) { [origin1, origin2] }
  let(:move_guerrillas_action) { described_class.new(origins, destination) }

  describe '#perform' do
    subject { move_guerrillas_action.perform }

    context 'when available guerrillas' do
      before do
        origin1.add_forces_to(CARTEL_FACTION, GUERRILLAS, 2)
        origin1.activate_guerrilla(CARTEL_FACTION)
        origin1.activate_guerrilla(CARTEL_FACTION)
        origin2.add_forces_to(CARTEL_FACTION, GUERRILLAS, 1)
        destination.add_forces_to(CARTEL_FACTION, BASES, 2)
      end

      it { expect(subject.size).to eq(3) }

      it { expect { subject }.to change { origin1.cartel_active_guerrillas_total }.from(2).to(0) }

      it { expect { subject }.to change { origin2.cartel_hidden_guerrillas_total }.from(1).to(0) }

      it { expect { subject }.to change { destination.cartel_hidden_guerrillas_total }.from(0).to(3) }
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

describe Ai::Factions::Cartel::Rally::AddGuerrillas do
  let(:board) { Board.new }
  let(:location) { board.locations.spaces.first }
  let(:location2) { board.locations.spaces.last }
  let(:add_guerrillas_action) { described_class.new(board, location) }

  describe '#perform' do
    subject { add_guerrillas_action.perform.first }

    context 'when available guerrillas' do
      before { board.add_forces_to(location, CARTEL_FACTION, BASES, 2) }

      it { expect(subject[:results]).to include(name: CARTEL_FACTION, force: GUERRILLAS, added: 12) }

      it { expect { subject }.to change { location.cartel_hidden_guerrillas_total }.from(0).to(12) }

      it { expect { subject }.to change { board.available_forces_for(CARTEL_FACTION, GUERRILLAS) }.from(12).to(0) }
    end

    context 'total depends on locations population' do
      let(:population) { 6 }

      before { board.add_forces_to(location, CARTEL_FACTION, BASES, 2) }

      it { expect(subject[:results]).to include(name: CARTEL_FACTION, force: GUERRILLAS, added: 12) }

      it { expect { subject }.to change { location.cartel_hidden_guerrillas_total }.from(0).to(12) }
    end

    context 'when there are no guerrillas available' do
      before do
        board.add_forces_to(location2, CARTEL_FACTION, GUERRILLAS, 99)
        board.add_forces_to(location, CARTEL_FACTION, BASES, 2)
      end

      it { is_expected.to be_nil }

      it { expect { subject }.to_not change { location.cartel_hidden_guerrillas_total } }
    end
  end
end

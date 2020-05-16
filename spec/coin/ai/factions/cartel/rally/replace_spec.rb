# frozen_string_literal: true

require 'rails_helper'

describe Ai::Factions::Cartel::Rally::Replace do
  let(:board) { Board.new }
  let(:location) { board.locations.spaces.first }
  let(:replace_action) { described_class.new(location, board) }

  describe '#perform' do
    subject { replace_action.perform.first }

    context 'when one base is available' do
      before do
        board.add_forces_to(location, AUC_FACTION, BASES, 1)
        board.add_forces_to(location, CARTEL_FACTION, GUERRILLAS, 3)
      end

      it { expect(subject[:results]).to include(name: CARTEL_FACTION, force: GUERRILLAS, removed: 2) }

      it { expect(subject[:results]).to include(name: CARTEL_FACTION, force: BASES, added: 1) }

      it { expect { subject }.to change { location.cartel_guerrillas_total }.from(3).to(1) }

      it { expect { subject }.to change { location.cartel_bases_total }.from(0).to(1) }
    end

    context 'when two bases are available but not enough guerrillas' do
      before do
        board.add_forces_to(location, CARTEL_FACTION, GUERRILLAS, 3)
      end

      it { expect(subject[:results]).to include(name: CARTEL_FACTION, force: GUERRILLAS, removed: 2) }

      it { expect(subject[:results]).to include(name: CARTEL_FACTION, force: BASES, added: 1) }

      it { expect { subject }.to change { location.cartel_guerrillas_total }.from(3).to(1) }

      it { expect { subject }.to change { location.cartel_bases_total }.from(0).to(1) }
    end
  end
end

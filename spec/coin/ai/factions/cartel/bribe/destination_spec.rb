# frozen_string_literal: true

require 'rails_helper'

describe Ai::Factions::Cartel::Bribe::Destination do
  let(:board) { Board.new }
  let(:location) { board.locations.populated.first }
  let(:bribe_destination) { described_class.new(location) }

  describe '#check' do
    subject { bribe_destination.check }

    it { is_expected.to eq(PRIORITY_AVOID) }

    context 'when cartel forces' do
      before do
        board.add_forces_to(location, CARTEL_FACTION, GUERRILLAS, 2)
      end

      context 'when there are no enemies' do
        it { is_expected.to eq(PRIORITY_AVOID) }
      end

      context 'when there are government troops' do
        before do
          board.add_forces_to(location, GOVT_FACTION, TROOPS, 2)
          board.add_forces_to(location, AUC_FACTION, GUERRILLAS, 6)
        end

        it { is_expected.to eq(PRIORITY_TOP) }
      end

      context 'when there are farc troops' do
        before do
          board.add_forces_to(location, FARC_FACTION, BASES, 2)
          board.add_forces_to(location, AUC_FACTION, GUERRILLAS, 6)
        end

        it { is_expected.to eq(PRIORITY_HIGH) }
      end

      context 'when there are auc troops' do
        before { board.add_forces_to(location, AUC_FACTION, GUERRILLAS, 1) }

        it { is_expected.to eq(PRIORITY_LOW) }
      end
    end
  end
end

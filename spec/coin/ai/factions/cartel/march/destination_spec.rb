# frozen_string_literal: true

require 'rails_helper'

describe Ai::Factions::Cartel::March::Destination do
  let(:board) { Board.new }
  let(:meta_west) { board.locations.find(21) }
  let(:hulia) { board.locations.find(13) }
  let(:adjacents) { board.locations.find_adjacents(meta_west) }
  let(:march_destination) { described_class.new(meta_west, adjacents) }

  describe '#check' do
    subject { march_destination.check }

    it { is_expected.to eq(PRIORITY_AVOID) }

    context 'when no bases and guerrillas available and guerrillas available in adjacent spaces' do
      before do
        board.add_forces_to(hulia, CARTEL_FACTION, GUERRILLAS, 2)
      end

      it { is_expected.to eq(PRIORITY_TOP) }
    end

    context 'when 1 base and guerrillas available and guerrillas available in adjacent spaces' do
      before do
        board.add_forces_to(meta_west, CARTEL_FACTION, BASES, 1)
        board.add_forces_to(hulia, CARTEL_FACTION, GUERRILLAS, 2)
      end

      it { is_expected.to eq(PRIORITY_TOP) }
    end

    context 'when move will activate troops' do
      before do
        board.add_forces_to(meta_west, GOVT_FACTION, TROOPS, 1)
        board.add_forces_to(meta_west, GOVT_FACTION, POLICE, 1)
        board.add_forces_to(meta_west, CARTEL_FACTION, BASES, 1)
        board.add_forces_to(hulia, CARTEL_FACTION, GUERRILLAS, 2)
      end

      it { is_expected.to eq(PRIORITY_NORMAL) }
    end

    context 'when no bases and guerrillas available and no guerrillas available in adjacent spaces' do
      before do
        board.add_forces_to(hulia, CARTEL_FACTION, GUERRILLAS, 1)
        board.add_forces_to(hulia, CARTEL_FACTION, BASES, 1)
      end

      it { is_expected.to eq(PRIORITY_AVOID) }
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

describe Ai::Factions::Cartel::Terror::Destination do
  let(:board) { Board.new }
  let(:location) { board.locations.find(21) }
  let(:terror_destination) { described_class.new(location) }

  describe '#check' do
    subject { terror_destination.check }

    it { is_expected.to eq(PRIORITY_AVOID) }

    context 'when population and underground guerrilla' do
      before do
        board.add_forces_to(location, CARTEL_FACTION, GUERRILLAS, 2)
      end

      context 'when support is neutral' do
        it { is_expected.to eq(PRIORITY_NORMAL) }
      end

      context 'when support is active' do
        before { location.increase_support }

        it { is_expected.to eq(PRIORITY_TOP) }
      end

      context 'when support is opposition' do
        before { 2.times { location.decrease_support } }

        it { is_expected.to eq(PRIORITY_LOW) }
      end
    end
  end
end

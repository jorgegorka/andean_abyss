# frozen_string_literal: true

require 'rails_helper'

describe Ai::Factions::Cartel::Rally::Index do
  let(:board) { Board.new }
  let(:location) { board.locations.spaces.first }
  let(:location2) { board.locations.spaces.last }
  let(:rally) { described_class.new(board) }

  describe '#perform' do
    subject { rally.perform[:activities] }

    it { expect(rally.perform).to eq(:not_available) }

    context 'when there is an available space for cultivation' do
      before do
        location.add_forces_to(CARTEL_FACTION, GUERRILLAS, 1)
      end

      it { expect(rally.perform[:action]).to eq(:cartel_rally) }

      it { is_expected.to be_an Array }

      it { expect(subject.first[:action]).to eq(:pre_cultivate) }

      it { expect(subject.last[:action]).to eq(:cultivate) }

      it 'should add a new base in a pre cultivated space' do
        expect(subject.last[:location].cartel_bases_total).to eq(1)
      end
    end

    context 'when there are available spaces to replace guerrillas with bases' do
      before do
        board.add_forces_to(location, CARTEL_FACTION, GUERRILLAS, 1)
        board.add_forces_to(location, GOVT_FACTION, POLICE, 3)
        board.add_forces_to(location2, CARTEL_FACTION, GUERRILLAS, 2)
        board.add_forces_to(location2, CARTEL_FACTION, BASES, 1)
      end

      it { expect(rally.perform[:action]).to eq(:cartel_rally) }

      it { is_expected.to be_an Array }

      it { expect(subject.first[:action]).to eq(:replace) }

      it { expect(subject.last[:action]).to eq(:cultivate) }
    end

    context 'when rally can not cultivate but can process' do
      before do
        board.add_forces_to(location, CARTEL_FACTION, GUERRILLAS, 1)
        board.add_forces_to(location, CARTEL_FACTION, BASES, 1)
        board.add_forces_to(location, GOVT_FACTION, POLICE, 3)
        board.add_forces_to(location2, CARTEL_FACTION, GUERRILLAS, 2)
        board.add_forces_to(location2, GOVT_FACTION, POLICE, 5)
        allow(board).to receive(:available_forces_for) { 0 }
      end

      it { expect(rally.perform[:action]).to eq(:cartel_rally) }

      it { is_expected.to be_an Array }

      it { expect(subject.first[:action]).to eq(:replace) }

      it { expect(subject.last[:action]).to eq(:process) }

      it 'should add two shipments to the selected location' do
        expect(subject.last[:location].shipments_total).to eq(2)
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

describe Ai::Factions::Cartel::March::Index do
  let(:board) { build(:board) }
  let(:meta_west) { board.locations.find(21) }
  let(:hulia) { board.locations.find(13) }
  let(:bogota) { board.locations.find(1) }
  let(:march_action) { described_class.new(board) }

  describe '#perform' do
    subject { march_action.perform[:activities] }

    it { expect(march_action.perform).to eq(:not_available) }

    describe 'when there are shipments available' do
      context 'when there are troops available to move' do
        before do
          board.add_forces_to(hulia, CARTEL_FACTION, GUERRILLAS, 2)
        end

        it { expect(march_action.perform[:action]).to eq(:cartel_march) }

        it { is_expected.to be_an Array }

        it { expect(subject.first[:action]).to eq(:march) }

        it { expect(subject.first[:results]).to include(name: CARTEL_FACTION, force: GUERRILLAS, removed: 2) }

        it { expect(subject.last[:results]).to include(name: CARTEL_FACTION, force: GUERRILLAS, added: 2) }
      end

      context 'when origin has a base' do
        before do
          board.add_forces_to(hulia, CARTEL_FACTION, BASES, 1)
          board.add_forces_to(hulia, CARTEL_FACTION, GUERRILLAS, 2)
        end

        it { expect(march_action.perform[:action]).to eq(:cartel_march) }

        it { is_expected.to be_an Array }

        it { expect(subject.first[:action]).to eq(:march) }

        it { expect(subject.first[:results]).to include(name: CARTEL_FACTION, force: GUERRILLAS, removed: 1) }

        it { expect(subject.last[:results]).to include(name: CARTEL_FACTION, force: GUERRILLAS, added: 1) }
      end

      context 'when more than one origin' do
        before do
          board.add_forces_to(hulia, CARTEL_FACTION, BASES, 1)
          board.add_forces_to(hulia, CARTEL_FACTION, GUERRILLAS, 2)
          board.add_forces_to(bogota, CARTEL_FACTION, BASES, 2)
          board.add_forces_to(bogota, CARTEL_FACTION, GUERRILLAS, 3)
        end

        it { expect(march_action.perform[:action]).to eq(:cartel_march) }

        it { is_expected.to be_an Array }

        it { expect(subject.first[:action]).to eq(:march) }

        it { expect(subject.first[:results]).to include(name: CARTEL_FACTION, force: GUERRILLAS, removed: 1) }

        it { expect(subject.last[:results]).to include(name: CARTEL_FACTION, force: GUERRILLAS, added: 3) }
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

describe Ai::Factions::Cartel::Terror::Index do
  let(:board) { build(:board) }
  let(:meta_west) { board.locations.find(21) }
  let(:hulia) { board.locations.find(13) }
  let(:bogota) { board.locations.find(1) }
  let(:terror_action) { described_class.new(board) }

  describe '#perform' do
    subject { terror_action.perform[:activities] }

    it { expect(terror_action.perform).to eq(:not_available) }

    context 'when there are spaces available for terror' do
      before do
        board.add_forces_to(meta_west, CARTEL_FACTION, GUERRILLAS, 2)
        board.add_forces_to(hulia, CARTEL_FACTION, GUERRILLAS, 2)
        board.add_forces_to(bogota, CARTEL_FACTION, GUERRILLAS, 1)
      end

      it { expect(terror_action.perform[:action]).to eq(:cartel_terror) }

      it { expect(subject).to be_an Array }

      it { expect(subject.size).to eq(3) }
    end
  end
end

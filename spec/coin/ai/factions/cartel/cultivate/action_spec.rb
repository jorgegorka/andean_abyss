# frozen_string_literal: true

require 'rails_helper'

describe Ai::Factions::Cartel::Cultivate::Action do
  let(:board) { Board.new }
  let(:meta_west) { board.locations.find(21) }
  let(:cultivate_action) { described_class.new(meta_west) }

  describe '#check' do
    subject { cultivate_action.check }

    it { is_expected.to eq(PRIORITY_NORMAL) }

    context 'if cant get more bases' do
      before { board.add_forces_to(meta_west, FARC_FACTION, BASES, 2) }

      it { is_expected.to eq(PRIORITY_AVOID) }
    end

    context 'when police exceed cartel guerrillas' do
      before { board.add_forces_to(meta_west, GOVT_FACTION, POLICE, 2) }
      before { board.add_forces_to(meta_west, CARTEL_FACTION, GUERRILLAS, 1) }
      before { board.add_forces_to(meta_west, FARC_FACTION, BASES, 1) }

      it { is_expected.to eq(PRIORITY_AVOID) }
    end
  end
end

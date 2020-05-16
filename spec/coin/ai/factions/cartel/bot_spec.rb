# frozen_string_literal: true

require 'rails_helper'

describe Ai::Factions::Cartel::Bot do
  let(:board) { build(:board) }
  let(:province) { board.locations.provinces.first }
  let(:province2) { board.locations.provinces[1] }
  let(:city) { board.locations.cities.last }
  let(:bot) { described_class.new(board) }

  before { board.cards_to_play(1, 2) }

  describe '#play' do
    subject { bot.play }

    context 'when action is rally' do
      before do
        board.add_forces_to(city, CARTEL_FACTION, GUERRILLAS, 2)
        board.add_forces_to(city, FARC_FACTION, GUERRILLAS, 2)
        board.add_forces_to(city, GOVT_FACTION, POLICE, 5)
        city.activate_guerrilla(CARTEL_FACTION)
      end

      it { expect(subject[:action]).to eq(:cartel_rally) }
    end

    context 'when action is march' do
      before do
        board.add_forces_to(city, CARTEL_FACTION, GUERRILLAS, 4)
        board.add_forces_to(city, CARTEL_FACTION, BASES, 2)
        board.add_forces_to(city, FARC_FACTION, GUERRILLAS, 2)
        board.add_forces_to(city, GOVT_FACTION, POLICE, 5)
        city.activate_guerrilla(CARTEL_FACTION)
        board.add_forces_to(province, CARTEL_FACTION, GUERRILLAS, 4)
        board.add_forces_to(province, CARTEL_FACTION, BASES, 2)
        board.add_forces_to(province2, CARTEL_FACTION, GUERRILLAS, 4)
        board.add_forces_to(province2, CARTEL_FACTION, BASES, 2)
        allow(board).to receive(:available_forces_for) { 0 }
      end

      it { expect(subject[:action]).to eq(:cartel_march) }
    end

    context 'when action is march' do
      before do
        board.add_forces_to(city, CARTEL_FACTION, GUERRILLAS, 4)
        board.add_forces_to(city, CARTEL_FACTION, BASES, 2)
        board.add_forces_to(city, FARC_FACTION, GUERRILLAS, 2)
        board.add_forces_to(city, GOVT_FACTION, POLICE, 5)
        city.activate_guerrilla(CARTEL_FACTION)
        board.add_forces_to(province, CARTEL_FACTION, GUERRILLAS, 4)
        board.add_forces_to(province, CARTEL_FACTION, BASES, 2)
        board.add_forces_to(province2, CARTEL_FACTION, GUERRILLAS, 4)
        board.add_forces_to(province2, CARTEL_FACTION, BASES, 2)
        board.remove_resources(:shipments, 4)
        allow(board).to receive(:available_forces_for) { 0 }
      end

      it { expect(subject[:action]).to eq(:cartel_terror) }
    end
  end
end

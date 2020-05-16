# frozen_string_literal: true

require 'rails_helper'

shared_examples 'board resources' do
  describe '#add_resources' do
    let(:faction) { GOVT_FACTION }
    let(:qty) { 23 }

    before { board.add_resources(faction, qty) }

    it { expect(board.resources[faction]).to eq(63) }
  end

  describe '#remove_resources' do
    let(:faction) { AUC_FACTION }
    let(:qty) { 23 }

    before do
      board.remove_resources(faction, 8)
    end

    it { expect(board.resources[faction]).to eq(2) }
  end

  describe '#add_shipment' do
    let(:faction) { CARTEL_FACTION }

    before do
      board.add_resources(:shipments, 4)
      board.add_forces_to(location, faction, GUERRILLAS, 1)
    end

    it { expect(board.resources[:shipments]).to eq(8) }

    context 'add shipment' do
      subject { board.add_shipment(location, faction) }

      it { expect(subject).to eq(1) }

      it { expect { subject } .to change { location.cartel_shipments_total }.from(0).to(1) }
    end
  end

  describe '#update_farc_victory_mark' do
    let(:location2) { board.locations.spaces[2] }

    subject { board.update_farc_victory_mark }

    context 'when there are spaces with passive support' do
      before do
        location.decrease_support
      end

      it { is_expected.to eq(location.population) }
    end

    context 'when there are farc bases' do
      before do
        board.add_forces_to(location, FARC_FACTION, BASES, 1)
        board.add_forces_to(location2, FARC_FACTION, BASES, 1)
      end

      it { is_expected.to eq(2) }
    end

    context 'when there are farc bases and opposition' do
      before do
        board.add_forces_to(location, FARC_FACTION, BASES, 1)
        board.add_forces_to(location2, FARC_FACTION, BASES, 1)
        2.times { location.decrease_support }
        location2.decrease_support
      end

      it { is_expected.to eq(21) }
    end
  end

  describe '#update_govt_victory_mark' do
    let(:location2) { board.locations.spaces[2] }

    subject { board.update_govt_victory_mark }

    context 'when there are spaces with support' do
      before do
        location2.decrease_support
        location.increase_support
      end

      it { is_expected.to eq(location.population) }
    end

    context 'when there are farc bases and opposition' do
      before do
        board.add_forces_to(location, FARC_FACTION, BASES, 1)
        board.add_forces_to(location2, FARC_FACTION, BASES, 1)
        2.times { location.increase_support }
        location2.increase_support
      end

      it { is_expected.to eq(19) }
    end
  end
end

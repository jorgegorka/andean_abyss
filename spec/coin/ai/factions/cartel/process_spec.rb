# frozen_string_literal: true

require 'rails_helper'

describe Ai::Factions::Cartel::Process do
  let(:board) { Board.new }
  let(:location) { board.locations.all.first }
  let(:process) { described_class.new(board) }
  let(:available_shipments) { 4 }

  describe '#perform' do
    subject { process.perform }

    before do
      board.add_resources(:shipments, available_shipments)
      board.add_forces_to(location, CARTEL_FACTION, GUERRILLAS, 2)
      board.add_forces_to(location, CARTEL_FACTION, BASES, 2)
      2.times { board.add_shipment(location, CARTEL_FACTION) }
    end

    context 'when there is only one space available' do
      it { expect(location.shipments_total).to eq(2) }
    end

    context 'when there is more than one space available' do
      let(:location2) { board.locations.all.last }

      before do
        board.add_forces_to(location2, CARTEL_FACTION, GUERRILLAS, 1)
        board.add_forces_to(location2, CARTEL_FACTION, BASES, 1)
      end

      it { expect { subject }.to change { board.resources[:shipments] }.from(6).to(4) }

      it { expect { subject }.to change { location2.shipments_total }.from(0).to(1) }

      it { expect { subject }.to change { location.shipments_total }.from(2).to(3) }
    end

    context 'when can remove base' do
      before { board.remove_resources(:shipments, 6) }

      it { expect { subject }.to change { location.cartel_bases_total }.from(2).to(1) }

      it { expect { subject }.to change { board.resources[CARTEL_FACTION] }.from(10).to(13) }
    end
  end
end

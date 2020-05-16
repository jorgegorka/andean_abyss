# frozen_string_literal: true

require 'rails_helper'

describe Ai::Factions::Cartel::Cultivate::Index do
  let(:board) { Board.new }
  let(:location) { board.locations.all.first }
  let(:location2) { board.locations.all.last }
  let(:action1) { { action: :pre_cultivate, location: location, results: [] } }
  let(:action2) { { action: :replace, location: location2, results: [] } }
  let(:actions) { [action1, action2] }
  let(:cultivate) { described_class.new(actions, board) }

  describe '#perform' do
    subject { cultivate.perform }

    context 'when available location selected for rally' do
      context 'when there are bases available' do
        it { expect(subject.first[:action]).to eq(:cultivate) }

        it { expect { subject }.to change { location.cartel_bases_total }.from(0).to(1) }
      end

      context 'when there are no bases available' do
        before { allow(board).to receive(:available_forces_for) { 0 } }

        it { is_expected.to eq(ACTION_NOT_AVAILABLE) }
      end
    end

    context 'when available location to relocate a base' do
      let(:actions) { [action2] }

      before { board.add_forces_to(location, CARTEL_FACTION, BASES, 2) }

      it { expect(subject.first[:action]).to eq(:cultivate) }

      it { expect(subject.last[:action]).to eq(:cultivate) }

      it { expect { subject }.to change { location.cartel_bases_total }.from(2).to(1) }
    end
  end
end

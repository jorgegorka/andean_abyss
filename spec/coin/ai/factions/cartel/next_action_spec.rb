# frozen_string_literal: true

require 'rails_helper'

describe Ai::Factions::Cartel::NextAction do
  let(:status) { [0, 0, 0, 0, 0] }
  let(:next_action) { described_class.new(status) }

  describe '#check' do
    subject { next_action.check }

    it { is_expected.to eq(:terror) }

    context 'when faction symbol is first in card order' do
      let(:status) { [1, 0, 0, 0, 0] }

      it { is_expected.to eq(:event) }
    end

    context 'when faction symbol is first in next card order' do
      let(:status) { [0, 1, 0, 0, 0] }

      it { is_expected.to eq(:pass) }
    end

    context 'when more than 9 guerrillas available' do
      let(:status) { [0, 0, 10, 0, 0] }

      it { is_expected.to eq(:rally) }
    end

    context 'when more than 9 guerrillas available and bases' do
      let(:status) { [0, 0, 9, 1, 0] }

      it { is_expected.to eq(:rally) }
    end

    context 'when a base can be placed' do
      let(:status) { [0, 0, 0, 1, 0] }

      it { is_expected.to eq(:rally) }
    end

    context 'when less than 10 guerrillas available and shipments' do
      let(:status) { [0, 0, 9, 0, 1] }

      it { is_expected.to eq(:march) }
    end

    context 'when shipments available' do
      let(:status) { [0, 0, 0, 0, 1] }

      it { is_expected.to eq(:march) }
    end

    context 'when shipments available and bases' do
      let(:status) { [0, 0, 0, 1, 5] }

      it { is_expected.to eq(:rally) }
    end
  end
end

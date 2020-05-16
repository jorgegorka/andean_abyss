# frozen_string_literal: true

require 'rails_helper'

describe Ai::Factions::Auc::NextAction do
  let(:status) { [0, 0, 0, 0, 0, 0] }
  let(:next_action) { described_class.new(status) }

  describe '#check' do
    subject { next_action.check }

    it { is_expected.to eq(:attack) }

    context 'when faction symbol is first in card order' do
      let(:status) { [1, 0, 0, 1, 0, 0] }

      it { is_expected.to eq(:event) }
    end

    context 'when faction symbol is first in next card order' do
      let(:status) { [0, 1, 0, 0, 1, 1] }

      it { is_expected.to eq(:pass) }
    end

    context 'when more than 6 guerrillas available' do
      let(:status) { [0, 0, 7, 0, 0, 0] }

      it { is_expected.to eq(:rally) }
    end

    context 'when a base can be placed' do
      let(:status) { [0, 0, 0, 1, 0, 0] }

      it { is_expected.to eq(:rally) }
    end

    context 'when presence in less than half spaces with farc bases' do
      let(:status) { [0, 0, 0, 0, 1, 0] }

      it { is_expected.to eq(:march) }
    end

    context 'when hidden guerrilla and farc base' do
      let(:status) { [0, 0, 2, 0, 0, 1] }

      it { is_expected.to eq(:terror) }
    end

    context 'when hidden guerrilla' do
      let(:status) { [0, 0, 0, 0, 0, 1] }

      it { is_expected.to eq(:terror) }
    end

    context 'when less than 6 guerrillas available' do
      let(:status) { [0, 0, 4, 0, 0, 0] }

      it { is_expected.to eq(:attack) }
    end

    context 'When no option available' do
      let(:status) { [0, 0, 0, 0, 0, 0] }

      it { is_expected.to eq(:attack) }
    end
  end
end

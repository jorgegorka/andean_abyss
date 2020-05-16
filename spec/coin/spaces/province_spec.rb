# frozen_string_literal: true

require 'rails_helper'

describe Spaces::Province do
  let(:province) { described_class.new(name: 'Arauca', population: 1, coastal: false) }

  describe '#province?' do
    subject { province.province? }

    it { is_expected.to be true }
  end

  describe '#loc?' do
    subject { province.loc? }

    it { is_expected.to be false }
  end

  describe '#city?' do
    subject { province.city? }

    it { is_expected.to be false }
  end

  describe 'support' do
    subject { province.support }

    it { is_expected.to eq(SUPPORT_NEUTRAL) }

    context 'when support decrease from neutral' do
      before { province.decrease_support }

      it { is_expected.to eq(SUPPORT_PASSIVE_OPPOSE) }
    end

    context 'when support decrease from passive oppose' do
      before { 2.times { province.decrease_support } }

      it { is_expected.to eq(SUPPORT_ACTIVE_OPPOSE) }
    end

    context 'when support increase from neutral' do
      before { province.increase_support }

      it { is_expected.to eq(SUPPORT_PASSIVE) }
    end

    context 'when support increase from passive support' do
      before { 2.times { province.increase_support } }

      it { is_expected.to eq(SUPPORT_ACTIVE) }
    end
  end
end

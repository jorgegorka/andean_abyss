# frozen_string_literal: true

require 'rails_helper'

describe Card do
  let(:card) { build(:card, order: order) }
  let(:order) { 'CAFG' }

  describe '#first_faction' do
    subject { card.first_faction?(CARTEL_FACTION) }

    it { is_expected.to be true }

    context 'when order of first faction is the requested' do
      let(:order) { 'GFCA' }
      it { is_expected.to be false }
    end
  end
end

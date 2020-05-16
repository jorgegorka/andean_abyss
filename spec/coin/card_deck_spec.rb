# frozen_string_literal: true

require 'rails_helper'

describe CardDeck do
  let(:card) do
    Card.new(
      number: 1,
      name: '1st Division',
      capability: CAPABILITY_GOVT,
      order: 'GFAC',
      propaganda: false
    )
  end
  let(:card_deck) { described_class.new([card]) }

  describe '#find' do
    subject { card_deck.find(1) }

    it { is_expected.to be_a Card }
  end
end

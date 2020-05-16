# frozen_string_literal: true

require 'rails_helper'

describe Board do
  let(:board) { described_class.new }
  let(:location) { board.locations.spaces.first }

  include_examples 'board resources'
  include_examples 'board forces'

  describe '#current_card' do
    before { board.cards_to_play(1, 4) }

    subject { board.current_card }

    it { is_expected.to be_a Card }
  end

  describe '#next_card' do
    before { board.cards_to_play(1, 4) }

    subject { board.next_card }

    it { is_expected.to be_a Card }
  end
end

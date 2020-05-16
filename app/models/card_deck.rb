# frozen_string_literal: true

# All cards available
class CardDeck
  class << self
    def generate(deck_content)
      cards = deck_content.map { |card_info| Card.new(card_info) }
      new(cards)
    end
  end
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def find(card_number)
    cards.find { |card| card.number == card_number }
  end
end

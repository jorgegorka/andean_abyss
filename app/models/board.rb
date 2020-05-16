# frozen_string_literal: true

# Main board
class Board
  include ActiveModel::Model
  include Forces
  include Resources
  include Totals

  attr_reader :locations, :current_card, :next_card, :propaganda, :resources

  def initialize(setup_info = STANDARD_DEPLOYMENT)
    @locations = Spaces::Locations.generate(LOCATIONS_CONTENT)
    @card_deck = CardDeck.generate(DECK_CONTENT)
    @propaganda = 0
    @aid = setup_info[:aid]
    @resources = setup_info[:resources].deep_dup
    @available_forces = setup_info[:forces].deep_dup
  end

  def cards_to_play(current, next_to_play)
    @current_card = card_deck.find(current)
    @next_card = card_deck.find(next_to_play)
  end

  private

  attr_reader :card_deck
end

# frozen_string_literal: true

# Card information
class Card
  attr_reader :capability, :name, :number, :order

  def initialize(capability:, name:, number:, order:, propaganda:)
    @capability = capability
    @name = name
    @number = number
    @order = order
    @propaganda = propaganda
  end

  def first_faction?(_faction)
    order[0] == CARTEL_FACTION[0].upcase
  end

  def any_capability?
    govt_capability? || momentum_capability?
  end

  def govt_capability?
    capability == CAPABILITY_GOVT
  end

  def momentum_capability?
    capability == CAPABILITY_MOMENTUM
  end
end

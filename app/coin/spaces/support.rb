# frozen_string_literal: true

module Spaces
  # Support logic for a location
  module Support
    attr_reader :support

    def has_support?
      support >= SUPPORT_PASSIVE
    end

    def has_opposition?
      support <= SUPPORT_PASSIVE_OPPOSE
    end

    def is_neutral?
      support == SUPPORT_NEUTRAL
    end

    def move_support_to(target)
      case target
      when :neutral
        move_support_to_neutral
      when :active
        increase_support
      when :passive
        decrease_support
      end
    end

    def increase_support
      update_support(1)
    end

    def decrease_support
      update_support(-1)
    end

    private

    def update_support(new_step)
      @support += new_step
      @support = 5 if @support > 5
      @support = 1 if @support < 1
    end

    def move_support_to_neutral
      return if support == SUPPORT_NEUTRAL

      support >= SUPPORT_PASSIVE ? decrease_support : increase_support
    end
  end
end

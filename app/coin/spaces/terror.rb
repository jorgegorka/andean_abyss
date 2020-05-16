# frozen_string_literal: true

module Spaces
  # Terror status of a location
  module Terror
    attr_reader :terror

    def increase_terror
      update_terrort(1)
    end

    def decrease_terror
      update_terrort(-1)
    end

    private

    def update_terrort(new_step)
      @terror += new_step
      @terror = 0 if @terror.negative?
    end
  end
end

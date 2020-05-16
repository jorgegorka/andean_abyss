# frozen_string_literal: true

require 'active_support/concern'

module Totals
  extend ActiveSupport::Concern

  included do
    def farc_bases_total
      locations.spaces.reduce(0) { |total, location| total + location.farc_bases_total }
    end

    def auc_bases_total
      locations.spaces.reduce(0) { |total, location| total + location.auc_bases_total }
    end

    def cartel_bases_total
      locations.spaces.reduce(0) { |total, location| total + location.cartel_bases_total }
      end
  end
end

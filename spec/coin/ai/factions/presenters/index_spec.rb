# frozen_string_literal: true

require 'rails_helper'

describe Ai::Factions::Presenters::Index do
  let(:location) { build(:province) }
  let(:activities) { [{ action: :replace, location: location, results: [] }] }
  let(:result_info) { { action: :cartel_rally, activities: activities } }
  let(:presenter) { described_class.new(result_info) }

  describe '#format' do
    subject { presenter.format }

    it { expect(subject[:action]).to eq(:cartel_rally) }

    it { expect(subject[:activities]).to be_an Array }
  end
end

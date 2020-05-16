# frozen_string_literal: true

require 'rails_helper'

describe Spaces::Locations do
  let(:province) { build(:province) }
  let(:locations) { described_class.new([province]) }

  describe '#find' do
    subject { locations.find(province.number) }

    it { is_expected.to be_a Spaces::Location }

    it { is_expected.to eql(province) }
  end
end

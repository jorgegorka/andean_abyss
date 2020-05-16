# frozen_string_literal: true

require 'rails_helper'

describe Ai::Factions::Presenters::Activity do
  let(:location) { build(:province) }
  let(:activity) { { action: :replace, location: location, results: results } }
  let(:presenter) { described_class.new(activity) }

  describe '#format' do
    subject { presenter.format }

    context 'when troops change' do
      let(:results) { [{ name: AUC_FACTION, force: GUERRILLAS, added: 2 }, { name: FARC_FACTION, force: GUERRILLAS, removed: 2 }] }

      it { expect(subject[:name]).to eq(location.name) }

      it { expect(subject[:control]).to eq('Control: none') }

      it { expect(subject[:actions]).to be_an Array }

      it { expect(subject[:actions]).to include(name: FARC_FACTION, force: GUERRILLAS, removed: 2) }

      it { expect(subject[:actions]).to include(name: AUC_FACTION, force: GUERRILLAS, added: 2) }
    end
  end
end

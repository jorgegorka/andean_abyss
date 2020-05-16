# frozen_string_literal: true

require 'rails_helper'

describe Ai::Factions::Cartel::Rally::Flip do
  let(:location) { build(:province) }
  let(:flip_action) { described_class.new(location) }

  describe '#perform' do
    before do
      location.add_forces_to(CARTEL_FACTION, BASES, 1)
      location.add_forces_to(CARTEL_FACTION, GUERRILLAS, 3)
      location.add_forces_to(GOVT_FACTION, TROOPS, 1)
      location.activate_guerrilla(CARTEL_FACTION)
      location.activate_guerrilla(CARTEL_FACTION)
      location.activate_guerrilla(CARTEL_FACTION)
    end
    subject { flip_action.perform.first }

    it { expect(subject[:results]).to include(name: CARTEL_FACTION, force: GUERRILLAS, flipped: 3) }

    it { expect { subject }.to change { location.cartel_hidden_guerrillas_total }.from(0).to(3) }

    it { expect { subject }.to change { location.cartel_active_guerrillas_total }.from(3).to(0) }
  end
end

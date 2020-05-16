# frozen_string_literal: true

require 'rails_helper'

describe Ai::Factions::Cartel::Rally::Action do
  let(:status) { [0, 0, 0, 0, 0] }
  let(:location) { build(:province) }
  let(:rally_action) { described_class.new(location) }

  describe '#check' do
    subject { rally_action.check }

    it { is_expected.to eq(CARTEL_ACTION_PASS) }

    context 'when bases troops and all guerrillas active' do
      before do
        location.add_forces_to(CARTEL_FACTION, BASES, 1)
        location.add_forces_to(GOVT_FACTION, POLICE, 1)
        location.add_forces_to(CARTEL_FACTION, GUERRILLAS, 2)
        location.forces[CARTEL_FACTION].activate_guerrilla
        location.forces[CARTEL_FACTION].activate_guerrilla
      end

      it { is_expected.to eq(CARTEL_ACTION_FLIP) }
    end

    context 'when at least 2 guerrillas, no shipments, less than 2 bases' do
      before do
        location.add_forces_to(CARTEL_FACTION, BASES, 1)
        location.add_forces_to(GOVT_FACTION, POLICE, 1)
        location.add_forces_to(CARTEL_FACTION, GUERRILLAS, 3)
        location.forces[CARTEL_FACTION].activate_guerrilla
      end

      it { is_expected.to eq(CARTEL_ACTION_REPLACE) }
    end

    context 'when bases and no guerrillas' do
      before do
        location.add_forces_to(CARTEL_FACTION, BASES, 2)
        location.add_forces_to(GOVT_FACTION, POLICE, 1)
      end

      it { is_expected.to eq(CARTEL_ACTION_ADD) }
    end

    context 'when can pre cultivate' do
      before do
        location.add_forces_to(CARTEL_FACTION, GUERRILLAS, 1)
      end

      it { is_expected.to eq(CARTEL_ACTION_CULTIVATE) }
    end
  end
end

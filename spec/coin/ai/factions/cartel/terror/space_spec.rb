# frozen_string_literal: true

require 'rails_helper'

describe Ai::Factions::Cartel::Terror::Space do
  let(:board) { build(:board) }
  let(:meta_west) { board.locations.find(21) }
  let(:hulia) { board.locations.find(13) }
  let(:bogota) { board.locations.find(1) }
  let(:terror_space) { described_class.new(bogota, board) }

  describe '#perform' do
    subject { terror_space.perform }

    before do
      2.times { bogota.increase_support }
      board.add_forces_to(bogota, CARTEL_FACTION, GUERRILLAS, 1)
    end

    it { expect { subject }.to change { bogota.cartel_hidden_guerrillas_total }.from(1).to(0) }

    it { expect { subject }.to change { bogota.terror }.from(0).to(1) }

    it { expect { subject }.to change { bogota.support }.from(SUPPORT_ACTIVE).to(SUPPORT_PASSIVE) }
  end
end

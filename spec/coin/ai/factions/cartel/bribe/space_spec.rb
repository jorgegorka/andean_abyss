# frozen_string_literal: true

require 'rails_helper'

describe Ai::Factions::Cartel::Bribe::Space do
  let(:board) { build(:board) }
  let(:bogota) { board.locations.spaces.first }
  let(:bribe_space) { described_class.new(bogota, board) }

  describe '#perform' do
    subject { bribe_space.perform }

    context 'when there are troops' do
      before do
        board.add_forces_to(bogota, GOVT_FACTION, TROOPS, 1)
        board.add_forces_to(bogota, AUC_FACTION, BASES, 1)
      end

      it { expect { subject }.to change { bogota.govt_troops_total }.from(1).to(0) }

      it { expect { subject }.to_not change { bogota.auc_bases_total } }
    end

    context 'when there are police' do
      before do
        board.add_forces_to(bogota, GOVT_FACTION, POLICE, 1)
        board.add_forces_to(bogota, FARC_FACTION, BASES, 1)
      end

      it { expect { subject }.to change { bogota.govt_police_total }.from(1).to(0) }

      it { expect { subject }.to_not change { bogota.auc_bases_total } }
    end

    context 'when there are troops and police' do
      before do
        board.add_forces_to(bogota, GOVT_FACTION, TROOPS, 1)
        board.add_forces_to(bogota, GOVT_FACTION, POLICE, 3)
        board.add_forces_to(bogota, FARC_FACTION, BASES, 1)
      end

      it { expect { subject }.to change { bogota.govt_troops_total }.from(1).to(0) }

      it { expect { subject }.to change { bogota.govt_police_total }.from(3).to(2) }

      it { expect { subject }.to_not change { bogota.auc_bases_total } }
    end

    context 'when there are farc guerrillas' do
      before do
        board.add_forces_to(bogota, FARC_FACTION, GUERRILLAS, 2)
        board.add_forces_to(bogota, AUC_FACTION, GUERRILLAS, 1)
      end

      it { expect { subject }.to change { bogota.farc_guerrillas_total }.from(2).to(0) }

      it { expect { subject }.to_not change { bogota.auc_guerrillas_total } }
    end

    context 'when there are auc guerrillas' do
      before do
        board.add_forces_to(bogota, AUC_FACTION, GUERRILLAS, 1)
        board.add_forces_to(bogota, AUC_FACTION, BASES, 1)
      end

      it { expect { subject }.to change { bogota.auc_guerrillas_total }.from(1).to(0) }

      it { expect { subject }.to_not change { bogota.auc_bases_total } }
    end

    context 'when there are farc and auc guerrillas' do
      before do
        board.add_forces_to(bogota, FARC_FACTION, GUERRILLAS, 1)
        board.add_forces_to(bogota, AUC_FACTION, GUERRILLAS, 4)
        board.add_forces_to(bogota, AUC_FACTION, BASES, 1)
      end

      it { expect { subject }.to change { bogota.farc_guerrillas_total }.from(1).to(0) }

      it { expect { subject }.to change { bogota.auc_guerrillas_total }.from(4).to(3) }

      it { expect { subject }.to_not change { bogota.auc_bases_total } }
    end

    context 'when there are govt bases' do
      before do
        board.add_forces_to(bogota, GOVT_FACTION, BASES, 2)
      end

      it { expect { subject }.to change { bogota.govt_bases_total }.from(2).to(1) }
    end

    context 'when there are farc bases' do
      before do
        board.add_forces_to(bogota, FARC_FACTION, BASES, 1)
        board.add_forces_to(bogota, AUC_FACTION, BASES, 1)
      end

      it { expect { subject }.to change { bogota.farc_bases_total }.from(1).to(0) }

      it { expect { subject }.to_not change { bogota.auc_bases_total } }
    end

    context 'when there are farc bases' do
      before do
        board.add_forces_to(bogota, AUC_FACTION, BASES, 1)
      end

      it { expect { subject }.to change { bogota.auc_bases_total }.from(1).to(0) }
    end
  end
end

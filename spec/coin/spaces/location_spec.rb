# frozen_string_literal: true

require 'rails_helper'

describe Spaces::Location do
  let(:forces) { build(:cartel_forces) }
  let(:location) { build(:province) }

  describe '#add_troops' do
    it 'should add guerrillas' do
      location.add_forces_to(AUC_FACTION, GUERRILLAS, 2)

      expect(location.auc_hidden_guerrillas.size).to eq(2)
    end
  end

  describe '#control' do
    subject { location.control }

    context 'when govt troops exceed others' do
      before do
        location.add_forces_to(GOVT_FACTION, TROOPS, 6)
        location.add_forces_to(AUC_FACTION, BASES, 1)
        location.add_forces_to(FARC_FACTION, GUERRILLAS, 2)
        location.add_forces_to(CARTEL_FACTION, GUERRILLAS, 2)
      end

      it { is_expected.to eq(CONTROL_GOVT) }
    end

    context 'when farc troops exceed all others' do
      before do
        location.add_forces_to(GOVT_FACTION, POLICE, 5)
        location.add_forces_to(GOVT_FACTION, TROOPS, 1)
        location.add_forces_to(FARC_FACTION, GUERRILLAS, 8)
        location.add_forces_to(AUC_FACTION, GUERRILLAS, 1)
      end

      it { is_expected.to eq(CONTROL_FARC) }
    end

    context 'when there are no govt troops nor farc' do
      it { is_expected.to eq(CONTROL_NONE) }
    end
  end

  describe '#farc_zone' do
    subject { location.farc_zone }

    it { is_expected.to be false }

    context 'when is a farc zone' do
      before { location.update_farc_zone(true) }

      it { is_expected.to be true }
    end
  end

  describe '#move_support_to' do
    describe 'when it moves to neutral' do
      subject { location.move_support_to(:neutral) }

      context 'when it is neutral' do
        it { expect { subject }.to_not change { location.support } }
      end

      context 'when it is active support' do
        before { 2.times { location.increase_support } }

        it { expect { subject }.to change { location.support }.from(SUPPORT_ACTIVE).to(SUPPORT_PASSIVE) }
      end

      context 'when it is passive support' do
        before { location.increase_support }

        it { expect { subject }.to change { location.support }.from(SUPPORT_PASSIVE).to(SUPPORT_NEUTRAL) }
      end

      context 'when it is active opposition' do
        before { 2.times { location.decrease_support } }

        it { expect { subject }.to change { location.support }.from(SUPPORT_ACTIVE_OPPOSE).to(SUPPORT_PASSIVE_OPPOSE) }
      end

      context 'when it is passive opposition' do
        before { location.decrease_support }

        it { expect { subject }.to change { location.support }.from(SUPPORT_PASSIVE_OPPOSE).to(SUPPORT_NEUTRAL) }
      end
    end
  end
end

# frozen_string_literal: true

shared_examples 'board forces' do
  describe '#add_forces_to' do
    let(:faction) { AUC_FACTION }
    let(:force) { GUERRILLAS }

    subject { board.add_forces_to(location, faction, force, qty) }

    context 'when there are enough troops available' do
      let(:qty) { 16 }

      it { expect { subject }.to change { location.auc_guerrillas_total }.from(0).to(16) }
    end

    context 'when there are not enough troops available' do
      let(:qty) { 89 }

      it { expect { subject }.to change { location.auc_guerrillas_total }.from(0).to(18) }
    end
  end

  describe '#available_forces_for' do
    let(:faction) { AUC_FACTION }
    let(:force) { GUERRILLAS }

    subject { board.available_forces_for(faction, force) }

    it { is_expected.to eq(18) }
  end
end

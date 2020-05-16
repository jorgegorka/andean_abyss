# frozen_string_literal: true
# # frozen_string_literal: true

# require 'rails_helper'

# describe Factions::Cartel::Assault do
#   let(:location) { build(:province, name: 'Ba Xuyen', population: 1, coastal: false, terrain: LOWLAND) }
#   let(:assault) { described_class.new(location) }
#   let(:remove_forces) do
#     [
#       { name: :nva, force: TROOPS, removed: 0, qty: 0 },
#       { name: :nva, force: :active_guerrillas, removed: 0, qty: 0 },
#       { name: :vc, force: :active_guerrillas, removed: 0, qty: 0 },
#       { name: :nva, force: BASES, removed: 0, qty: 0 },
#       { name: :vc, force: BASES, removed: 0, qty: 0 }
#     ]
#   end

#   describe '#assault?' do
#     subject { assault.assault }

#     describe 'when no forces can be removed' do
#       before :each do
#         location.forces[:nva].add(TROOPS, 2)
#         location.forces[:nva].add(GUERRILLAS, 2)
#         location.forces[:nva].activate_guerrilla
#         location.forces[:vc].add(GUERRILLAS, 3)
#         location.forces[:vc].activate_guerrilla
#         location.forces[:vc].activate_guerrilla
#       end

#       it { is_expected.to be_nil }
#     end

#     describe 'when forces can be removed' do
#       context 'troops and guerrilas' do
#         let(:nva_removed) { { name: :nva, force: TROOPS, removed: 2, qty: 2 } }
#         let(:nva_guerrillas_removed) { { name: :nva, force: :active_guerrillas, removed: 1, qty: 1 } }
#         let(:vc_removed) { { name: :vc, force: :active_guerrillas, removed: 2, qty: 2 } }

#         before :each do
#           location.forces[:us].add(TROOPS, 4)
#           location.forces[:nva].add(TROOPS, 2)
#           location.forces[:nva].add(GUERRILLAS, 2)
#           location.forces[:nva].activate_guerrilla
#           location.forces[:vc].add(GUERRILLAS, 3)
#           location.forces[:vc].activate_guerrilla
#           location.forces[:vc].activate_guerrilla
#         end

#         it { is_expected.to include nva_removed }
#         it { is_expected.to include nva_guerrillas_removed }
#         it { is_expected.to include vc_removed }
#       end

#       context 'nva troops and vc guerrillas' do
#         let(:nva_removed) { { name: :nva, force: TROOPS, removed: 2, qty: 2 } }
#         let(:vc_removed) { { name: :vc, force: :active_guerrillas, removed: 2, qty: 2 } }

#         before :each do
#           location.forces[:us].add(TROOPS, 4)
#           location.forces[:nva].add(TROOPS, 2)
#           location.forces[:vc].add(GUERRILLAS, 3)
#           location.forces[:vc].activate_guerrilla
#           location.forces[:vc].activate_guerrilla
#         end

#         it { is_expected.to include nva_removed }
#         it { is_expected.to include vc_removed }
#       end

#       context 'nva troops, vc guerrillas and nva bases' do
#         let(:nva_removed) { { name: :nva, force: TROOPS, removed: 2, qty: 2 } }
#         let(:nva_guerrillas_removed) { { name: :nva, force: :active_guerrillas, removed: 2, qty: 2 } }
#         let(:nva_base_removed) { { name: :nva, force: BASES, removed: 1, qty: 1 } }
#         let(:vc_removed) { { name: :vc, force: :active_guerrillas, removed: 2, qty: 2 } }

#         before :each do
#           location.forces[:us].add(TROOPS, 6)
#           location.forces[:nva].add(TROOPS, 2)
#           location.forces[:nva].add(BASES, 1)
#           location.forces[:nva].add(GUERRILLAS, 2)
#           location.forces[:nva].activate_guerrilla
#           location.forces[:nva].activate_guerrilla
#           location.forces[:vc].add(GUERRILLAS, 3)
#           location.forces[:vc].activate_guerrilla
#           location.forces[:vc].activate_guerrilla
#         end

#         it { is_expected.to include nva_removed }
#         it { is_expected.to include nva_guerrillas_removed }
#         it { is_expected.to include vc_removed }
#         it { is_expected.to include nva_base_removed }
#       end

#       context 'nva troops, vc guerrillas, nva bases and vc bases' do
#         let(:nva_removed) { { name: :nva, force: TROOPS, removed: 2, qty: 2 } }
#         let(:nva_guerrillas_removed) { { name: :nva, force: :active_guerrillas, removed: 2, qty: 2 } }
#         let(:nva_base_removed) { { name: :nva, force: BASES, removed: 1, qty: 1 } }
#         let(:nva_base_removed) { { name: :vc, force: BASES, removed: 2, qty: 2 } }
#         let(:vc_removed) { { name: :vc, force: :active_guerrillas, removed: 2, qty: 2 } }

#         before :each do
#           location.forces[:us].add(TROOPS, 6)
#           location.forces[:nva].add(TROOPS, 2)
#           location.forces[:nva].add(BASES, 1)
#           location.forces[:nva].add(GUERRILLAS, 2)
#           location.forces[:nva].activate_guerrilla
#           location.forces[:nva].activate_guerrilla
#           location.forces[:vc].add(GUERRILLAS, 3)
#           location.forces[:vc].activate_guerrilla
#           location.forces[:vc].activate_guerrilla
#           location.forces[:vc].add(BASES, 2)
#         end

#         it { is_expected.to include nva_removed }
#         it { is_expected.to include nva_guerrillas_removed }
#         it { is_expected.to include vc_removed }
#         it { is_expected.to include nva_base_removed }
#       end
#     end
#   end
# end

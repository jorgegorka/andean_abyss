# frozen_string_literal: true
# # frozen_string_literal: true

# require 'rails_helper'

# describe Factions::Cartel::AirLift do
#   let(:origin) { build(:province) }
#   let(:destination) { build(:city) }
#   let(:forces) do
#     [
#       { name: :us, force: TROOPS, qty: 5 },
#       { name: :arvn, force: TROOPS, qty: 2 },
#       { name: :arvn, force: POLICE, qty: 3 }
#     ]
#   end
#   let(:air_lift) { described_class.new(origin, destination, forces) }

#   describe '#move' do
#     before do
#       origin.add_forces_to(:us, TROOPS, 5)
#       origin.add_forces_to(:arvn, TROOPS, 3)
#       origin.add_forces_to(:arvn, POLICE, 3)
#       destination.add_forces_to(:arvn, TROOPS, 3)
#       destination.add_forces_to(:arvn, POLICE, 1)
#       air_lift.move
#     end

#     it { expect(origin.cartel_troops).to eq(0) }

#     it { expect(origin.arvn_troops).to eq(1) }

#     it { expect(origin.arvn_police).to eq(0) }

#     it { expect(destination.cartel_troops).to eq(5) }

#     it { expect(destination.arvn_troops).to eq(5) }

#     it { expect(destination.arvn_police).to eq(4) }
#   end
# end

require_relative 'room_state'
require_relative 'amphipod_mover'

class RandomState
    attr_reader :state

    def initialize
        state = {
            h1:  nil,
            h2:  nil,
            h3:  nil,
            h4:  nil,
            h5:  nil,
            h6:  nil,
            h7:  nil,
            h8:  nil,
            h9:  nil,
            h10: nil,
            h11: nil,
            a1:  'D',
            a2:  'D',
            a3:  'D',
            a4:  'D',
            b1:  'B',
            b2:  'C',
            b3:  'B',
            b4:  'A',
            c1:  'C',
            c2:  'B',
            c3:  'A',
            c4:  'B',
            d1:  'C',
            d2:  'A',
            d3:  'C',
            d4:  'A',
        }

        values = []
        7.times { values << nil }
        4.times { values << 'A' }
        4.times { values << 'B' }
        4.times { values << 'C' }
        4.times { values << 'D' }
        values.shuffle!

        positions = [:h1, :h2, :h4, :h6, :h8, :h10, :h11, :a1, :a2, :a3, :a4, :b1, :b2, :b3, :b4, :c1, :c2, :c3, :c4, :d1, :d2, :d3, :d4]

        positions.each { |pos| state[pos] = values.pop }

        @state = RoomState.new(state: state, cost: 0)

        p @state.id

        puts @state.printable_state
    end
end

5.times do
    puts "================\n\n"
    rand = RandomState.new
    puts "\n\n"
end

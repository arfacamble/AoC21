require_relative 'room_state'
require_relative 'amphipod_mover'

id_1 = :"h1=C_h2=_h3=_h4=A_h5=_h6=B_h7=_h8=_h9=_h10=_h11=_a1=_a2=_a3=A_a4=_b1=D_b2=A_b3=B_b4=B_c1=B_c2=A_c3=D_c4=C_d1=C_d2=D_d3=C_d4=D"
id_2 = :"h1=A_h2=_h3=_h4=_h5=_h6=A_h7=_h8=B_h9=_h10=C_h11=D_a1=D_a2=B_a3=_a4=A_b1=D_b2=A_b3=B_b4=_c1=C_c2=_c3=B_c4=D_d1=_d2=C_d3=_d4=C"
id_3 = :"h1=_h2=D_h3=_h4=C_h5=_h6=A_h7=_h8=A_h9=_h10=D_h11=D_a1=B_a2=C_a3=_a4=D_b1=C_b2=A_b3=_b4=_c1=C_c2=B_c3=A_c4=_d1=B_d2=_d3=_d4=B"
id_4 = :"h1=_h2=A_h3=_h4=_h5=_h6=_h7=_h8=D_h9=_h10=C_h11=C_a1=_a2=A_a3=_a4=_b1=D_b2=B_b3=C_b4=B_c1=_c2=A_c3=B_c4=D_d1=D_d2=A_d3=B_d4=C"
id_5 = :"h1=C_h2=_h3=_h4=D_h5=_h6=C_h7=_h8=_h9=_h10=B_h11=B_a1=_a2=_a3=A_a4=_b1=_b2=C_b3=C_b4=B_c1=_c2=A_c3=D_c4=D_d1=A_d2=A_d3=D_d4=B"

state_1 = RoomState.new(id: id_1, cost: 0)
state_2 = RoomState.new(id: id_2, cost: 0)
state_3 = RoomState.new(id: id_3, cost: 0)
state_4 = RoomState.new(id: id_4, cost: 0)
state_5 = RoomState.new(id: id_5, cost: 0)

# puts state_1.printable_state
# puts state_2.printable_state
# puts state_3.printable_state
# puts state_4.printable_state
# puts state_5.printable_state

state_1_moves = [
    {
        type: 'A',
        start: :a3,
        end: :h2
    },
    {
        type: 'A',
        start: :a3,
        end: :a1
    },
    {
        type: 'A',
        start: :a3,
        end: :a2
    },
    {
        type: 'A',
        start: :a3,
        end: :a4
    },
    {
        type: 'A',
        start: :h4,
        end: :a1
    },
    {
        type: 'A',
        start: :h4,
        end: :a2
    },
    {
        type: 'B',
        start: :c1,
        end: :h8
    },
    {
        type: 'B',
        start: :c1,
        end: :h10
    },
    {
        type: 'B',
        start: :c1,
        end: :h11
    },
    {
        type: 'C',
        start: :d1,
        end: :h8
    },
    {
        type: 'C',
        start: :d1,
        end: :h10
    },
    {
        type: 'C',
        start: :d1,
        end: :h11
    },
]

state_2_moves = [
    {
        type: 'D',
        start: :a1,
        end: :h2
    },
    {
        type: 'D',
        start: :a1,
        end: :h4
    },
    {
        type: 'D',
        start: :b1,
        end: :h2
    },
    {
        type: 'D',
        start: :b1,
        end: :h4
    }
]

state_3_moves = []

state_4_moves = [
    {
        type: 'A',
        start: :h2,
        end: :a1
    },
    {
        type: 'A',
        start: :a2,
        end: :a1
    },
    {
        type: 'A',
        start: :a2,
        end: :a3
    },
    {
        type: 'A',
        start: :a2,
        end: :a4
    },
    {
        type: 'A',
        start: :a2,
        end: :h4
    },
    {
        type: 'A',
        start: :a2,
        end: :h6
    },
    {
        type: 'A',
        start: :c2,
        end: :a1
    },
    {
        type: 'A',
        start: :c2,
        end: :h4
    },
    {
        type: 'A',
        start: :c2,
        end: :h6
    },
    {
        type: 'D',
        start: :b1,
        end: :h4
    },
    {
        type: 'D',
        start: :b1,
        end: :h6
    },
]

state_5_moves = [
    {
        type: 'A',
        start: :a3,
        end: :a1
    },
    {
        type: 'A',
        start: :a3,
        end: :a2
    },
    {
        type: 'A',
        start: :a3,
        end: :a4
    },
    {
        type: 'A',
        start: :a3,
        end: :h2
    },
    {
        type: 'A',
        start: :c2,
        end: :h8
    },
    {
        type: 'A',
        start: :d1,
        end: :h8
    },
]

def print_all(next_states)
    next_states.each_slice(10) { |s| print_chunks(s) }
end

def print_chunks(next_states)
    printable = next_states.map(&:printable_state)
    lines = Array.new(8, '')
    printable.each do |state|
        state.each_with_index { |line, i| lines[i] += "  |  #{line}" }
    end
    puts lines
end

def equal(move1, move2)
    move1[:start] == move2[:start] &&
        move1[:end] == move2[:end] &&
        move1[:type] == move2[:type]
end

def test(state, expected_moves)
    mover = AmphipodMover.new(state)
    new_states = mover.new_states
    valid_moves = mover.valid_moves
    expected_moves_count = expected_moves.size
    puts "\n\n=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=\nFor the following state\n"
    puts state.printable_state
    puts "Expecting #{expected_moves.size} moves   Found #{valid_moves.size} moves   and #{new_states.size} new states"
    valid_moves.each do |v_m|
        e_i = expected_moves.index { |e_m| equal(v_m, e_m) }
        e_i ? expected_moves.delete_at(e_i) : (puts "Move not found in expected: #{v_m}")
    end
    puts "expected moves not found by mover:" if expected_moves.any?
    expected_moves.each { |e_m| p e_m }
    puts "Correct moves count: #{valid_moves.size == expected_moves_count}"
end

test(state_1, state_1_moves)
test(state_2, state_2_moves)
test(state_3, state_3_moves)
test(state_4, state_4_moves)
test(state_5, state_5_moves)
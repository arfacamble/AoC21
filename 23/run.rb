require_relative '../heap/heap'
require_relative 'room_state'
require_relative 'amphipod_mover'

start_input = {
    cost: 0,
    state: {
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
}

class AmphiDijkstra
    def initialize(start_input)
        @start_time = Time.now
        @last_print_time = Time.now
        @heap = Heap.new { |a, b| a[:cost] < b[:cost] }
        start_state = RoomState.new(start_input)
        @heap << heap_room_state(start_state)
        @visited = {}
        @final_cost = nil
        # @print_mode = true
        @print_mode = false
        # 25.times { run }
        until @final_cost
            run
        end
        puts "calcumalations completed"
        puts "the cheapest way to move the amphipods to the right places is #{@final_cost}"
        puts "This was found in #{(Time.now - @start_time).round(4)} seconds"
        puts "incidentally the number of states left in the heap at this time is #{@heap.size}"
        puts "and the number of states that have been visited is #{@visited.size}"
    end

    def run
        # @print_mode = false
        # if (t = Time.now) - @last_print_time > 5
        #     @print_mode = true
        #     @last_print_time = t
        # end
        puts '==========================================================' if @print_mode
        visiting = RoomState.new(@heap.pop)
        puts visiting.printable_state if @print_mode
        puts "The heap now holds #{@heap.size} states." if @print_mode
        @final_cost = visiting.cost if visiting.complete?
        return if @final_cost
        @visited[visiting.id] = visiting.cost
        next_states = AmphipodMover.new(visiting).new_states
        puts "#{next_states.size} new amphipod arrangements found" if @print_mode
        print_all(next_states) if @print_mode
        add_to_heap(next_states)
        puts "The heap now holds #{@heap.size} states. Total run time so far: #{(Time.now - @start_time).round(3)} seconds" if @print_mode
    end

    def add_to_heap(next_states)
        next_states.each do |state|
            next if @visited[state.id]
            heap_room_state = heap_room_state(state)
            if i = @heap.hashmap[state.id]
                @heap.offer_at(i, heap_room_state)
            else
                @heap << heap_room_state
            end
        end
    end
    
    def heap_room_state(state)
        {
            id: state.id,
            cost: state.cost
        }
    end

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
end

AmphiDijkstra.new(start_input)

# require_relative 'random_state'
# rando = RandomState.new
# AmphiDijkstra.new(state: rando.state.state, cost: rando.state.cost)
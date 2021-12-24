require_relative 'rb_heap'

# TODO test if complete

class AmphipodOrganiser
    def initialize
        @start_time = Time.now
        @last_print_time = Time.now
        @current_state = nil
        @move_cost = {
            'A' => 1,
            'B' => 10,
            'C' => 100,
            'D' => 1000
        }
        @valid_hallway_stops = [:h1, :h2, :h4, :h6, :h8, :h10, :h11]
        @invalid_hallway_stops = [:h3, :h5, :h7, :h9]
        start_state = {
            cost: 0,
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
        end_state = {
            cost: 0,
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
            a1:  'A',
            a2:  'A',
            a3:  'A',
            a4:  'A',
            b1:  'B',
            b2:  'B',
            b3:  'B',
            b4:  'B',
            c1:  'C',
            c2:  'C',
            c3:  'C',
            c4:  'C',
            d1:  'D',
            d2:  'D',
            d3:  'D',
            d4:  'D',
        } # for testing complete test
        # puts "It is #{!equal?(start_state, end_state)} that my equal function works"
        # p '--------------'
        # puts "It is #{equal?(start_state, start_state)} that my equal function works"
        @links = {
            h1:  [:h2],
            h2:  [:h1, :h3],
            h3:  [:h2, :h4, :a1],
            h4:  [:h3, :h5],
            h5:  [:h4, :h6, :b1],
            h6:  [:h5, :h7],
            h7:  [:h6, :h8, :c1],
            h8:  [:h7, :h9],
            h9:  [:h8, :h10, :d1],
            h10: [:h9, :h11],
            h11: [:h10],
            a1:  [:h3, :a2],
            a2:  [:a1, :a3],
            a3:  [:a2, :a4],
            a4:  [:a3],
            b1:  [:h5, :b2],
            b2:  [:b1, :b3],
            b3:  [:b2, :b4],
            b4:  [:b3],
            c1:  [:h7, :c2],
            c2:  [:c1, :c3],
            c3:  [:c2, :c4],
            c4:  [:c3],
            d1:  [:h9, :d2],
            d2:  [:d1, :d3],
            d3:  [:d2, :d4],
            d4:  [:d3],
        }
        @visited_states = []
        @states = Heap.new
        @states << start_state
        @cost_to_complete = nil
        until @cost_to_complete
            move
        end
        puts "WE GOT TO THE EEEEEEEND!!!!!"
        puts "The lowest cost possible is #{@cost_to_complete}"
    end

    def move
        # take state with lowest cost
        puts "Visited count : #{@visited_states.size}"
        puts "Queue count : #{@states.size}"
        @current_state = @states.pop
        @visited_states << @current_state
        if Time.now - @last_print_time > 0.5
            @last_print_time = Time.now
            puts "So far this \"Dijkstra\" search has been running for #{(Time.now - @start_time).round(2)} seconds"
            puts "The current state under consideration is as follows:"
            draw_state(@current_state)
        end        
        # find all legal moves and costs
        next_moves = moves_and_costs
        # create new states
        new_states = next_moves.map do |move|
            state = clone(@current_state)
            state[move[:start]] = nil
            state[move[:end]] = move[:type]
            state[:cost] += move[:cost]
            # p move
            # print_state(state)
            # draw_state(state)
            state
        end
        update_states(new_states)
    end

    def update_states(new_states)
        new_states.each do |new_state|
            p new_state
            if complete?(new_state)
                @cost_to_complete = new_state[:cost]
                return
            end
            if (@visited_states.find { |visited| equal?(visited, new_state) })
                next
            end
            i = @states.heap.index { |state| equal?(state, new_state) }
            if i
                @states.offer_at(i, new_state)
            else
                @states << new_state
            end
        end
    end

    def complete?(state)
        state.all? do |pos, val|
            if pos == :cost
                true
            elsif pos.to_s[0].upcase == 'A'
                val == 'A'
            elsif pos.to_s[0].upcase == 'B'
                val == 'B'
            elsif pos.to_s[0].upcase == 'C'
                val == 'C'
            elsif pos.to_s[0].upcase == 'D'
                val == 'D'
            else
                true
            end
        end
    end

    def moves_and_costs
        # returns [[start_pos, end_pos, cost], [start_pos, end_pos, cost], [start_pos, end_pos, cost]]
        move_starts = @current_state.filter { |key, amphipod| key != :cost && amphipod }
        moves_and_costs = []
        move_starts.each { |pos, amphipod| moves_and_costs += find_moves(pos, amphipod) }
        moves_and_costs
    end

    def find_moves(pos, type)
        complete = []
        in_progress = [[pos]]
        until in_progress.empty?
            paths = in_progress
            in_progress = []
            paths.each do |path|
                next_stops = @links[path[-1]]
                next_stops.each do |next_stop|
                    next if next_stop == path[-2] || @current_state[next_stop] || wrong_room(type, next_stop)
                    new_path = path + [next_stop]
                    complete << new_path unless @invalid_hallway_stops.include?(next_stop) 
                    in_progress << new_path
                end
            end
        end
        complete.reject! { |path| path[0].to_s[0] == 'h' && path[-1].to_s[0] == 'h' }
        complete.map { |path| convert_path(path, type) }
    end

    def convert_path(path, type)
        cost = (path.size - 1) * @move_cost[type]
        {
            start: path.first,
            end: path[-1],
            cost: cost,
            type: type
        }
    end

    def equal?(state1, state2)
        state1.all? do |key, val|
            key == :cost || val == state2[key]
        end
    end

    def wrong_room(type, next_stop)
        next_room = next_stop.to_s[0].upcase
        next_room != 'H' && next_room != type
    end

    def clone(state)
        Marshal.load(Marshal.dump(state))
    end

    def print_state(state)
        state.each { |pos, val| puts "#{pos} -> #{val}" }
    end

    def draw_states
        @states.each { |state| draw_state(state)} 
    end

    def draw_state(state)
        11.times { print '-' }
        print '            '
        puts "Cost: #{state[:cost]}"

        (:h1..:h9).each { |pos| print (a = state[pos]) ? a : ' ' }
        (:h10..:h11).each { |pos| print (a = state[pos]) ? a : ' ' }
        puts ' '

        2.times { print '-' }
        print (a = state[:a1]) ? a : ' '
        print '-'
        print (a = state[:b1]) ? a : ' '
        print '-'
        print (a = state[:c1]) ? a : ' '
        print '-'
        print (a = state[:d1]) ? a : ' '
        2.times { print '-' }
        puts ' '

        2.times { print '-' }
        print (a = state[:a2]) ? a : ' '
        print '-'
        print (a = state[:b2]) ? a : ' '
        print '-'
        print (a = state[:c2]) ? a : ' '
        print '-'
        print (a = state[:d2]) ? a : ' '
        2.times { print '-' }
        puts ' '

        2.times { print '-' }
        print (a = state[:a3]) ? a : ' '
        print '-'
        print (a = state[:b3]) ? a : ' '
        print '-'
        print (a = state[:c3]) ? a : ' '
        print '-'
        print (a = state[:d3]) ? a : ' '
        2.times { print '-' }
        puts ' '

        2.times { print '-' }
        print (a = state[:a4]) ? a : ' '
        print '-'
        print (a = state[:b4]) ? a : ' '
        print '-'
        print (a = state[:c4]) ? a : ' '
        print '-'
        print (a = state[:d4]) ? a : ' '
        2.times { print '-' }
        puts ' '

        11.times { print '-' }
        puts ' '
    end
end

corridor = AmphipodOrganiser.new
corridor.draw_states


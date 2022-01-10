require_relative 'room_state'

class AmphipodMover
    attr_reader :new_states, :valid_moves

    def initialize(start_state)
        @start_state = start_state
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
        @invalid_hallway_stops = [:h3, :h5, :h7, :h9]
        @move_cost = {
            'A' => 1,
            'B' => 10,
            'C' => 100,
            'D' => 1000
        }
        @complete = []
        @valid_moves = []
        moves_and_costs
        @new_states = @valid_moves.map do |move|
            current_state = clone(@start_state.state)
            current_state[move[:start]] = nil
            current_state[move[:end]] = move[:type]
            cost = @start_state.cost + move[:cost]
            RoomState.new(cost: cost, state: current_state)
        end
    end

    def moves_and_costs
        move_starts = @start_state.state.filter { |_key, amphipod| amphipod }
        move_starts.each { |pos, amphipod| find_moves(pos, amphipod) }
        @valid_moves = @complete.map { |path| convert_path(path) }
    end

    def find_moves(pos, type)
        in_progress = [[pos]]
        until in_progress.empty?
            paths = in_progress
            in_progress = []
            paths.each do |path|
                # puts "Building #{path} for type #{type}"
                next_stops = @links[path[-1]]
                next_stops.each do |next_stop|
                    # puts "Next stop: #{next_stop}"
                    reversing = next_stop == path[-2]
                    position_occupied = @start_state.state[next_stop]
                    next if reversing || position_occupied
                    new_path = path + [next_stop]
                    # puts "New path: #{new_path}"
                    bad_hallway_stop = @invalid_hallway_stops.include?(next_stop)
                    hallway_only = start_and_end_hallway(new_path[0], next_stop)
                    @complete << new_path unless bad_hallway_stop || bad_room(type, next_stop) || hallway_only
                    in_progress << new_path
                end
            end
        end
    end

    def convert_path(path)
        type = @start_state.state[path[0]]
        cost = (path.size - 1) * @move_cost[type]
        {
            start: path.first,
            end: path[-1],
            cost: cost,
            type: type
        }
    end

    def bad_room(type, next_stop)
        wrong_room(type, next_stop) || wronguns_in_room(next_stop)
    end

    def wronguns_in_room(next_stop)
        room_type = room_type(next_stop)
        return false if room_type == 'h'
        amphipod_type = room_type.upcase
        all_spots_of_type = []
        (1..4).each { |num| all_spots_of_type << "#{room_type}#{num}".to_sym }
        no_problem = all_spots_of_type.all? { |spot| @start_state.state[spot] == nil || @start_state.state[spot] == amphipod_type }
        !no_problem
    end

    def wrong_room(type, next_stop)
        next_room = next_stop.to_s[0].upcase
        next_room != 'H' && next_room != type
    end

    def start_and_end_hallway(first, last)
        room_type(first) == 'h' && room_type(last) == 'h'
    end

    def clone(state)
        Marshal.load(Marshal.dump(state))
    end

    def room_type(room_code)
        room_code.to_s[0]
    end
end
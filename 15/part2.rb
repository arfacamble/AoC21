require_relative 'data'
require_relative 'heap'
real_start_time = Time.now
data = parse_part2(DATA)
example = parse_part2(EXAMPLE)

# {
#     coord: "_#{x}_#{y}".to_sym,
#     x: x,
#     y: y,
#     arrival_cost: val,
#     route_cost: Float::INFINITY
# }

class DijkstraDoer
    def initialize(input)
        @start_time = Time.now
        @height = input[:height]
        @width = input[:width]
        @nodes = Heap.new { |a,b| a[:route_cost] < b[:route_cost] }
        input[:nodes].each { |n| @nodes << n }
        @visited_nodes = {}
        compoot
    end

    def compoot
        until @nodes.empty?
            # nodes_left = @nodes.size
            # if nodes_left % 100 == 0
            #     puts "#{Time.now - @start_time} seconds elapsed... #{nodes_left} nodes left..."
            # end
            node_to_visit = @nodes.pop
            # puts '=========================================================='
            # puts "about to visit #{node_to_visit}"
            # puts '=========================================================='
            visit(node_to_visit)
        end
    end

    def visit(node_visiting)
        # p '==================='
        # puts "Visiting #{node_visiting}, according to hash map it is at index #{@nodes.coord_to_index[node_visiting[:coord]]}"
        # puts '_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_'
        if node_visiting[:x] == @width - 1 && node_visiting[:y] == @height - 1
            puts "HEEEEEEEERRE"
            puts "cost is #{node_visiting[:route_cost]}"
            puts "time taken: #{Time.now - @start_time}"
        end
        adjacent_node_coords = find_adjacent_to(node_visiting[:x], node_visiting[:y])
        # puts "the next to visit: #{adjacent_node_coords}"
        adjacent_node_coords.each { |coord| update_route_cost(coord, node_visiting[:route_cost]) }
        @visited_nodes[node_visiting[:coord]] = node_visiting
    end

    def update_route_cost(coord, cost_so_far)
        return if @visited_nodes[coord]
        i = @nodes.coord_to_index[coord]
        node = @nodes.heap[i]
        # puts "update_route_cost: visiting node #{node} at index #{i} with coord #{coord}"
        # p node
        new_cost = cost_so_far + node[:arrival_cost]
        # puts "new cost is #{new_cost}"
        if new_cost < node[:route_cost]
            new_node = clone(node)
            new_node[:route_cost] = new_cost
            # puts "we are offering #{new_node}"
            @nodes.offer_at(i, new_node)
        end
    end

    def find_adjacent_to(x, y)
        adjacent_coords = [
            [x-1,y],
            [x+1,y],
            [x,y-1],
            [x,y+1]
        ]
        adjacents = []
        adjacent_coords.each do |x, y|
            unless x < 0 || y < 0 || x >= @width || y >= @height
                adjacents << "_#{x}_#{y}".to_sym
            end
        end
        adjacents
    end

    def clone(obj)
        Marshal.load(Marshal.dump(obj))
    end
end

d = DijkstraDoer.new(data)
puts "Full time taken = #{Time.now - real_start_time} seconds"
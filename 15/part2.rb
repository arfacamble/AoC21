require_relative 'data'

data = parse_part2(DATA)
example = parse_part2(EXAMPLE)

class DijkstraDoer
    def initialize(input)
        @start_time = Time.now
        @height = input[:height]
        @width = input[:width]
        @nodes = input[:nodes]
        @visited_nodes = []
        compoot
    end

    def compoot
        until @nodes.empty?
            nodes_left = @nodes.size
            if nodes_left % 100 == 0
                puts "#{Time.now - @start_time} seconds elapsed... #{nodes_left} nodes left..."
            end
            node_to_visit = @nodes.min { |node| node[:route_cost] }
            # @nodes = @nodes.sort_by { |node| node[:route_cost] }
            visit(node_to_visit)
        end
    end

    def visit(node_visiting)
        index = @nodes.index { |node| node[:coord] == node_visiting[:coord] }
        @nodes.delete_at(index)
        if node_visiting[:x] == @width - 1 && node_visiting[:y] == @height - 1
            puts "HEEEEEEEERRE"
            puts "cost is #{node_visiting[:route_cost]}"
        end
        adjacent_nodes = find_adjacent_to(node_visiting[:x], node_visiting[:y])
        adjacent_nodes.each { |node| update_route_cost(node, node_visiting[:route_cost]) }
        @visited_nodes << node_visiting
    end

    def update_route_cost(node, cost_so_far)
        new_cost = cost_so_far + node[:arrival_cost]
        node[:route_cost] = new_cost if new_cost < node[:route_cost]
    end

    def find_adjacent_to(x, y)
        adjacents = [
            "_#{x-1}_#{y}",
            "_#{x+1}_#{y}",
            "_#{x}_#{y-1}",
            "_#{x}_#{y+1}",
        ]
        adjacents.map { |coord| @nodes.find { |node| node[:coord.to_sym] } }
                 .reject { |node| node.nil? }
    end
end

DijkstraDoer.new(example)

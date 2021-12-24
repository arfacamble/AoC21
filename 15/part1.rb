start_time = Time.now
require_relative 'data'

data = parse_part2(DATA)

width = data[:width]
height = data[:height]
nodes = data[:nodes]
# eg  {:coord=>[8, 0], :arrival_cost=>4, :route_cost=>Infinity}

def adjacent_nodes(coord, nodes)
    adjacent_nodes = []

    left_coord = [coord[0] - 1, coord[1]]
    left = nodes.find { |node| node[:coord] == left_coord }
    adjacent_nodes << left unless left.nil?

    right_coord = [coord[0] + 1, coord[1]]
    right = nodes.find { |node| node[:coord] == right_coord }
    adjacent_nodes << right unless right.nil?

    up_coord = [coord[0], coord[1] - 1]
    up = nodes.find { |node| node[:coord] == up_coord }
    adjacent_nodes << up unless up.nil?

    down_coord = [coord[0], coord[1] + 1]
    down = nodes.find { |node| node[:coord] == down_coord }
    adjacent_nodes << down unless down.nil?

    adjacent_nodes
end

def update_route_cost(node, current_cost)
    new_cost = current_cost + node[:arrival_cost]
    node[:route_cost] = new_cost if new_cost < node[:route_cost]
end

visited_nodes = []

puts "STARTING... #{nodes.size} nodes to visit"

until nodes.empty?
    # puts "==========================================="
    # puts "#{nodes.size} nodes left"
    # determine node to 'visit'
    nodes = nodes.sort_by { |node| node[:route_cost] }
    nodes_left = nodes.size
    if nodes_left % 100 == 0
        puts "#{Time.now - start_time} seconds elapsed... #{nodes_left} nodes left..."
    end
    node_visiting = nodes.shift
    # p node_visiting
    # visit that node by
        # updating route cost for adjacent nodes
    adjacent_nodes = adjacent_nodes(node_visiting[:coord], nodes)
    # p adjacent_nodes
    adjacent_nodes.each { |node| update_route_cost(node, node_visiting[:route_cost]) }
        # moving that node to visited nodes
    visited_nodes << node_visiting
end

last = visited_nodes.find { |node| node[:coord] == [width - 1, height - 1] }
p last[:route_cost]
puts "Duration: #{Time.now - start_time}"
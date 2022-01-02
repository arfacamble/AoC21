require_relative 'parse'
require_relative 'map_reactor'

start_time = Time.now
# input = parse(BABIEST_EXAMPLE)
# input = parse(BABY_EXAMPLE)
# input = parse(EXAMPLE)
input = parse(BABY_DATA)
# input = parse(DATA)

reactor_start_time = Time.now
puts "data parse in #{(reactor_start_time - start_time).round(2)} seconds"
reactor = MapReactor.new(input)
p reactor.on_blocks.sum { |block| block.volume }

end_time = Time.now
puts "Reactor booted in #{(end_time - reactor_start_time).round(2)} seconds"
puts "Total time: #{(end_time - start_time).round(2)} seconds"


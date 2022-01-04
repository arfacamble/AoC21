require_relative 'cuboid'
require_relative 'overlapper'
require_relative 'map_reactor'
require_relative 'parse'

# # testing finding the overlap

# cuboid_a = Cuboid.new(x: 3..10, y: 17..35, z: 4..9)
# cuboid_in = Cuboid.new(x: 5..7, y: 18..22, z: 6..7)
# cuboid_out = Cuboid.new(x: 0..10, y: 15..43, z: 4..13)
# cuboid_b1 = Cuboid.new(x: 7..22, y: 32..37, z: 5..10)
# cuboid_b2 = Cuboid.new(x: 0..11, y: 10..21, z: 0..5)
# cuboid_no = Cuboid.new(x: 12..22, y: 10..22, z: 0..2)

# puts "\n=========================================\n
# 'Add' a cuboid INSIDE the original\nnew: #{cuboid_in.dimensions}\n"
# overlapper = Overlapper.new(original: cuboid_a, change: cuboid_in, switch: 'on')
# puts "original: #{cuboid_a.dimensions}"
# puts "overlap: #{overlapper.overlap}"

# puts "\n=========================================\n
# 'Add' a cuboid with NO overlap\nnew: #{cuboid_no.dimensions}\n"
# overlapper = Overlapper.new(original: cuboid_a, change: cuboid_no, switch: 'on')
# puts "original: #{cuboid_a.dimensions}"
# puts "overlap: #{overlapper.overlap}"

# puts "\n=========================================\n
# 'Add' a cuboid that entirely COVERS the original\nnew: #{cuboid_out.dimensions}\n"
# overlapper = Overlapper.new(original: cuboid_a, change: cuboid_out, switch: 'on')
# puts "original: #{cuboid_a.dimensions}"
# puts "overlap: #{overlapper.overlap}"

# puts "\n=========================================\n
# 'Add' a cuboid with a CORNER overlap\nnew: #{cuboid_b1.dimensions}\n"
# overlapper = Overlapper.new(original: cuboid_a, change: cuboid_b1, switch: 'on')
# puts "original: #{cuboid_a.dimensions}"
# puts "overlap: #{overlapper.overlap}"

# puts "\n=========================================\n
# 'Add' a cuboid with a bits EITHER SIDE overlap\nnew: #{cuboid_b2.dimensions}\n"
# overlapper = Overlapper.new(original: cuboid_a, change: cuboid_b2, switch: 'on')
# puts "original: #{cuboid_a.dimensions}"
# puts "overlap: #{overlapper.overlap}"

# # testing subtracting overlap from cuboid to get remaining chunks
# biggun = Cuboid.new(x: 0..10, y: 0..35, z: 0..9)
# biggunish = Cuboid.new(x: 0..10, y: 0..25, z: 0..9)
# corner = Cuboid.new(x: 0..2, y: 0..5, z: 0..6)
# edge = Cuboid.new(x: 3..6, y: 0..5, z: 0..6)
# plane = Cuboid.new(x: 3..6, y: 5..9, z: 0..6)
# middle = Cuboid.new(x: 3..6, y: 5..9, z: 4..6)

# puts "\n=========================================\n
# Remaining chunks when subtracting a cuboid that fills MOST\nsubtract: #{biggunish.dimensions}\nfrom: #{biggun.dimensions}"
# overlapper = Overlapper.new(original: biggunish, change: biggun, switch: 'on')
# puts "Remains:"
# overlapper.to_do.each do |cuboid|
#     p cuboid.dimensions
# end

# puts "\n=========================================\n
# Remaining chunks when subtracting a cuboid that is in the CORNER\nsubtract: #{corner.dimensions}\nfrom: #{biggun.dimensions}"
# overlapper = Overlapper.new(original: corner, change: biggun, switch: 'on')
# puts "Remains:"
# overlapper.to_do.each do |cuboid|
#     p cuboid.dimensions
# end

# puts "\n=========================================\n
# Remaining chunks when subtracting a cuboid that is on an EDGE\nsubtract: #{edge.dimensions}\nfrom: #{biggun.dimensions}"
# overlapper = Overlapper.new(original: edge, change: biggun, switch: 'on')
# puts "Remains:"
# overlapper.to_do.each do |cuboid|
#     p cuboid.dimensions
# end

# puts "\n=========================================\n
# Remaining chunks when subtracting a cuboid that is on a PLANE\nsubtract: #{plane.dimensions}\nfrom: #{biggun.dimensions}"
# overlapper = Overlapper.new(original: plane, change: biggun, switch: 'on')
# puts "Remains:"
# overlapper.to_do.each do |cuboid|
#     p cuboid.dimensions
# end

# puts "\n=========================================\n
# Remaining chunks when subtracting a cuboid that is in the MIDDLE\nsubtract: #{middle.dimensions}\nfrom: #{biggun.dimensions}"
# overlapper = Overlapper.new(original: middle, change: biggun, switch: 'on')
# puts "Remains:"
# overlapper.to_do.each do |cuboid|
#     p cuboid.dimensions
# end

# testing whether the final result has any overlapping cuboids

# input = parse(BABIEST_EXAMPLE)
# input = parse(BABY_EXAMPLE)
# input = parse(EXAMPLE)
input = parse(BABY_DATA)
# input = parse(DATA)

def any_overlaps?(map)
    map.on_blocks.each_with_index do |block1, i|
        map.on_blocks[i+1..].each do |block2|
            overlap_data = Overlapper.new(original: block1, change: block2)
            if overlap_data.overlaps
                puts "--------------------------"
                puts "ALERT OVERLAPPING CUBES!!!"
                p block1.dimensions
                p block2.dimensions
                puts "--------------------------"
            end
        end
    end
    puts "finished test"
end

map = MapReactor.new(input)
any_overlaps?(map)

# no overlaps for examples, but plenty for DATA - all around x: -6..-6
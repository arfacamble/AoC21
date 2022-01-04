require_relative 'cuboid'
require_relative 'map_reactor'
require_relative 'overlapper'

c_one = Cuboid.new(x: 0..19, y: 0..10, z: 0..9)
c_two = Cuboid.new(x: 19..27, y: 2..7, z: 1..5)
c_three = Cuboid.new(x: 19..27, y: 2..7, z: 1..5)

c_2x1 = Cuboid.new(x: 20..27, y: 2..7, z: 1..5)

c_1x1 = Cuboid.new(x: 0..19, y: 0..10, z: 0..9)
c_1x2 = Cuboid.new(x: 18..19, y: 0..10, z: 6..9)
c_1x3 = Cuboid.new(x: 18..19, y: 8..10, z: 0..5)
c_1x4 = Cuboid.new(x: 18..19, y: 0..1, z: 0..5)
c_1x5 = Cuboid.new(x: 18..19, y: 2..7, z: 0..0)

# overlapper = Overlapper.new(original:c_one, change:c_two, switch: 'off')
# p overlapper

test_1 = {
    input: [
        { switch: 'on', cuboid: c_one },
        { switch: 'on', cuboid: c_two }
    ],
    output: {
        blocks: [ c_one, c_2x1 ],
        volume: 2440
    }
}

test_2 = {
    input: [
        { switch: 'on', cuboid: c_one },
        { switch: 'off', cuboid: c_two }
    ],
    output: {
        blocks: [ c_1x1, c_1x2, c_1x3, c_1x4, c_1x5 ],
        volume: 2170
    }
}

def test(test_data)
    input = test_data[:input]
    map = MapReactor.new(input)
    expected_volume = test_data[:output][:volume]
    puts "  Correct volume?"
    volume_match = map.volume == expected_volume
    puts volume_match.to_s.upcase
    puts "actual: #{map.volume} - expected: #{expected_volume}" if !volume_match

    expected_blocks = test_data[:output][:blocks]
    actual = map.on_blocks
    if expected_blocks.size == actual.size
        puts "\nBoth actual and expected contain #{actual.size} blocks."
    else
        puts "\nMismatch in number of blocks!! actual has #{actual.size} but expected has #{expected_blocks.size}"
    end

    puts "\n  Matching Cuboids:"
    not_found = []
    until actual.empty?
        block = actual.pop
        i = expected_blocks.index { |x_block| x_block.equal(block) }
        if i
            puts "matched: #{block.dimensions}"
            expected_blocks.delete_at(i)
        else
            not_found << block
        end
    end
    if not_found.any?
        puts "\nCuboids in actual result not matched:"
        not_found.each { |b| p b.dimensions }
    end
    if expected_blocks.any?
        puts "\nCuboids expected but not found in actual result:"
        expected_blocks.each { |b| p b.dimensions }
    end
end

puts "\n=============================================\n\n"
puts "          Testing c_one + c_two\n\n"
test(test_1)

puts "\n=============================================\n\n"
puts "          Testing c_one - c_two\n\n"
test(test_2)
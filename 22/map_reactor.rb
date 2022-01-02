require_relative 'overlapper'

# instruction example: {:switch=>"on", :cuboid=>#<Cuboid:0x0000020c7f4bbb70 @x=-17..30, @y=-5..41, @z=-33..14>}

class MapReactor
    attr_reader :on_blocks

    def initialize(instructions)
        @on_blocks = []     # should be filled with Cuboids
        instructions.each do |instruction|
            instruction[:switch] == 'on' ? switch_on(instruction[:cuboid]) : switch_off(instruction[:cuboid])
        end
    end

    def switch_on(cuboid)
        @on_blocks.each do |original|
            overlap_data = Overlapper.new(original: original, change: cuboid, switch: 'on')
            if overlap_data.overlaps
                overlap_data.to_do.each { |todo| switch_on(todo) }
                return
            end
        end
        @on_blocks << cuboid
    end

    def switch_off(cuboid)
        @on_blocks.each_with_index do |original, i|
            overlap_data = Overlapper.new(original: original, change: cuboid, switch: 'off')
            if overlap_data.overlaps
                @on_blocks.delete_at(i)
                @on_blocks += overlap_data.original_minus_overlap
                overlap_data.to_do.each { |todo| switch_off(todo) }
                return
            end
        end
    end
end
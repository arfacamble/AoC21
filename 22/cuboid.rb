class Cuboid
    attr_accessor :x, :y, :z
    def initialize(input)
        @x = input[:x]
        @y = input[:y]
        @z = input[:z]
    end

    def dimensions
        {
            x: @x,
            y: @y,
            z: @z,
        }
    end

    def volume
        @x.size * @y.size * @z.size
    end

    def equal(other_cuboid)
        dimensions == other_cuboid.dimensions
    end
end
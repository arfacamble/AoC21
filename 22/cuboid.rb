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
end
require_relative 'parse'
require 'set'

data = parse(DATA)
example = parse(EXAMPLE)

# {:switch=>"on", :x=>-20..26, :y=>-36..17, :z=>-47..7}
# {:switch=>"on", :x=>-20..33, :y=>-21..23, :z=>-26..28}

class ReactorController
    def initialize(instructions)
        @start_time = Time.now
        @on = []
        # filled with things like { :x=>-20..26, :y=>-36..17, :z=>-47..7 }
        @instructions = instructions
        compoot
    end

    def compoot
        @instructions.each do |struc|
            if struc[:switch] == 'on'
                switch_on([struc.reject { |k, _v| k == :switch }])
            else
                switch_off(struc)
            end
        end
    end

    def switch_on(range_arr)
        # range_arr each check @on each for overlap
        range_arr.each do |range|
            @on.each do |on_range|
                if overlaps = overlaps(on_range, range)
                    switch_on(overlaps)
                    next
                end
            end
        end
            # when overlap found split new cuboid into several -> recursive -> return
            # when not, add to @on
    end
end

ReactorController.new(example)

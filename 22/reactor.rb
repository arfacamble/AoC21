require_relative 'parse'
require 'set'

data = parse(DATA)
example = parse(EXAMPLE)

# {:switch=>"on", :x=>-20..26, :y=>-36..17, :z=>-47..7}
# {:switch=>"on", :x=>-20..33, :y=>-21..23, :z=>-26..28}

class ReactorController
    def initialize(instructions)
        @start_time = Time.now
        @on = {}
        @instructions = instructions
        compoot
    end

    def compoot
        @instructions.each_with_index do |struc, i|
            struc[:x].each do |x|
                struc[:y].each do |y|
                    @on[y] = {} if @on[y].nil?
                    row = @on[y]
                    row[x] = [] if row[x].nil?
                    coord = row[x]
                    z_vals = struc[:z].to_a
                    row[x] = (struc[:switch] == 'on') ? coord | z_vals : coord - z_vals
                end
            end
            count = count_on
            puts "Completed instruction #{i + 1}... Duration: #{(Time.now - @start_time).round(3)} seconds (#{count} coords in @on)"
        end
    end

    def count_on
        count_start_time = Time.now
        count = 0
        @on.each_value do |row|
            row.each_value do |coord|
                count += coord.size
            end
        end
        puts "count time: #{(Time.now - count_start_time).round(3)} seconds"
        count
    end
end

ReactorController.new(data)

# (-20..26).each {|num| p num}
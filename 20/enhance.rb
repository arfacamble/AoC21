require_relative 'data'

example = parse(EXAMPLE)
data = parse(DATA)

class ImageEnhancer
    attr_reader :image

    def initialize(input)
        @enhancer = input[:enhancer]
        @image = input[:image]
        @growth_count = 0
    end

    def enhance
        grow_edges
        @growth_count += 1
        new_image = []
        @image.each_with_index do |row, y_pos|
            unless y_pos == 0 || y_pos == @height - 1
                new_image << []
                row.each_with_index do |_p, x_pos|
                    unless x_pos == 0 || x_pos == @width - 1
                        nine_bit = []
                        nine_bit << @image[y_pos - 1][(x_pos - 1)..(x_pos + 1)]
                        nine_bit << @image[y_pos][(x_pos - 1)..(x_pos + 1)]
                        nine_bit << @image[y_pos + 1][(x_pos - 1)..(x_pos + 1)]
                        nine_bit = nine_bit.flatten.map { |bit| bit == '#' ? 1 : 0 }
                        num = convert_bi_to_num(nine_bit)
                        pixel = @enhancer[num]
                        new_image[-1] << pixel
                    end
                end
            end
        end
        @image = new_image
    end

    def count_lit_pixels
        @image.flatten.count { |pixel| pixel == '#' }
    end

    def convert_bi_to_num(bits)
        num = 0
        bits.reverse.each_with_index { |bit, index| num += bit * 2**index }
        num
    end

    def grow_edges
        grow_char = @growth_count.even? ? '.' : '#'
        @height = @image.size
        @width = @image.first.size
        2.times { @image.unshift(Array.new(@width, grow_char)) }
        2.times { @image.push(Array.new(@width, grow_char)) }
        @image.map do |line|
            2.times { line.unshift(grow_char) }
            2.times { line.push(grow_char) }
        end
        @height += 4
        @width += 4
    end
end
start_time = Time.now
image = ImageEnhancer.new(data)
50.times { image.enhance }
p image.count_lit_pixels
puts "Duration: #{Time.now - start_time} seconds"
class MagnitudeFinder
    attr_reader :snail_num, :magnitude

    def initialize(snail_num)
        @snail_num = snail_num
        @conversion_done = false
        arrayize until @conversion_done
        @snail_num = @snail_num.first
        @magnitude = find_magnitude(@snail_num)
    end

    def find_magnitude(arr)
        first_half = arr[0].is_a?(Integer) ? 3 * arr[0] : 3 * find_magnitude(arr[0])
        second_half = arr[1].is_a?(Integer) ? 2 * arr[1] : 2 * find_magnitude(arr[1])
        first_half + second_half
    end

    def arrayize
        last_opener = nil
        @snail_num.each_with_index do |char, i|
            if char == '['
                last_opener = i
            elsif char == ']'
                chunk = @snail_num[(last_opener + 1)...i]
                @snail_num.slice!(last_opener..i)
                @snail_num.insert(last_opener, chunk)
                return
            end
        end
        @conversion_done = true
    end
end

# require_relative 'parse'

# tests = {
#     1 => {
#         in: convert('[[1,2],[[3,4],5]]'),
#         out: 143
#     },
#     2 => {
#         in: convert('[[[[0,7],4],[[7,8],[6,0]]],[8,1]]'),
#         out: 1384
#     },
#     3 => {
#         in: convert('[[[[1,1],[2,2]],[3,3]],[4,4]]'),
#         out: 445
#     },
#     4 => {
#         in: convert('[[[[3,0],[5,3]],[4,4]],[5,5]]'),
#         out: 791
#     },
#     5 => {
#         in: convert('[[[[5,0],[7,4]],[5,5]],[6,6]]'),
#         out: 1137
#     },
#     6 => {
#         in: convert('[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]'),
#         out: 3488
#     },
# }

# tests.each do |num, in_out|
#     puts "\n==================================\n"
#     puts "Test #{num}"
#     actual = MagnitudeFinder.new(in_out[:in]).magnitude
#     puts actual == in_out[:out] ? 'PASSED!!!' : "Failed: actual = #{actual} ; expected = #{in_out[:out]}"
# end
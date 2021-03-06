# p :a1.to_s[0] != 'a'
# p :b1.to_s[0] != 'a'

# array = [2,5,7,7,7,9,15]
# inserters = [3,3,7,8,12,15,16]
# array.delete_at(-1)
# p array
# empty = []
# empty.delete_at(-1)
# p empty
# p array[nil]

require_relative 'rb_heap'

puts "BIG HEAP:"

heap = Heap.new { |a, b| a[:cost] < b[:cost] }

heap << {cost: 4, a1: nil }
heap << {cost: 7, a1: 'D' }
heap << {cost: 3, a1: 'A' }
heap << {cost: 6, a1: 'B' }
heap << {cost: 9, a1: 'C' }
heap << {cost: 2, a1: 'F' }
heap << {cost: 9, a1: 'D' }
heap << {cost: 1, a1: 'B' }
heap << {cost: 4, a1: 'D' }
heap << {cost: 2, a1: 'A' }
heap << {cost: 7, a1: 'A' }

p heap.pop

# line_width = 1
# line_count = 0
# heap.heap.each do |s|
#     print s[:cost]
#     line_count += 1
#     if line_count == line_width
#         line_width *= 2
#         line_count = 0
#         puts ''
#     end
# end

puts "\n\nHEAP WITH ONE:"

heap_one = Heap.new { |a, b| a[:cost] < b[:cost] }

heap_one << {cost: 7, a1: 'D' }

p heap_one.pop

puts "\n\nHEAP WITH NONE:"

heap_none = Heap.new { |a, b| a[:cost] < b[:cost] }
p heap_one.pop

# new_state = { cost: 10, a1: 'F' }
# i = heap.heap.index { |node| node[:a1] == new_state[:a1] }
# p i
# heap.offer_at(i, new_state)

# p heap

# thing = {cost: 4, a1: nil }

# clone = thing.clone
# clone[:a1] = 3

# p thing
# p clone


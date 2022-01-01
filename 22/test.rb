arr1 = [3,4,5,6,7]
arr2 = [3,4,5,9,10,11]
arr3 = arr2.shuffle
range1 = 4..6
range2 = 6..9

# p arr1.intersection(range1.to_a)
# p arr1.union(range1.to_a)
# p arr1.union(range2.to_a)
# p arr3
# p arr3.union(range1.to_a)
# p arr3.intersection(range1.to_a)

# p range1.include?(5)
# # p range1.intersection(range2)     ERROR no method

# p (1..3).size


# (1..9).to_a - (1..7).to_a

require_relative 'overlapper'
require_relative 'cuboid'

biggun = Cuboid.new(x: 0..10, y: 0..35, z: 0..9)
biggun.send(:x=, 0..5)
p biggun
# biggunish = Cuboid.new(x: 0..10, y: 0..25, z: 0..9)

# p Overlapper.new(original: biggunish, change: biggun, switch: 'on').range_subtract(34..78, 35..56).filter { |r| r.last >= r.first }
# p Overlapper.new(original: biggunish, change: biggun, switch: 'on').range_subtract(34..78, 43..56).filter { |r| r.last >= r.first }
# p Overlapper.new(original: biggunish, change: biggun, switch: 'on').range_subtract(77..78, 43..565).filter { |r| r.last >= r.first }


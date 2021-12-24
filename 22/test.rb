arr1 = [3,4,5,6,7]
arr2 = [3,4,5,9,10,11]
arr3 = arr2.shuffle
range1 = 4..6
range2 = 6..9

p arr1.intersection(range1.to_a)
p arr1.union(range1.to_a)
p arr1.union(range2.to_a)
p arr3
p arr3.union(range1.to_a)
p arr3.intersection(range1.to_a)
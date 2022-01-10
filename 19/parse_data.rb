require_relative 'data'

def parse(input)
    scanners = input.split("\n\n").map { |s| s.split("\n") }
    final_scanners = {}
    scanners.each do |scanner|
        num = scanner.shift
                     .split[2]
                     .to_i
        beacons = []
        scanner.map! { |coord| coord.split(',').map!(&:to_i) }
        scanner.each do |beacon|
            beacons << {
                x: beacon[0],
                y: beacon[1],
                z: beacon[2]
            }
        end
        final_scanners[num] = beacons
    end
    final_scanners
end

def clone(hash)
    Marshal.load(Marshal.dump(hash))
end

def print_quadrant_count(data)
    quadrants = {
        x_pos: {
            y_pos: {
                z_pos: 0,
                z_neg: 0
            },
            y_neg: {
                z_pos: 0,
                z_neg: 0
            }
        },
        x_neg: {
            y_pos: {
                z_pos: 0,
                z_neg: 0
            },
            y_neg: {
                z_pos: 0,
                z_neg: 0
            }
        }
    }

    data.each do |scanner, beacons|
        puts "\n\n=====================================\n\nScanner #{scanner}:\n"
        quads = clone(quadrants)
        beacons.each do |beacon|
            x = beacon[:x].positive? ? :x_pos : :x_neg
            y = beacon[:y].positive? ? :y_pos : :y_neg
            z = beacon[:z].positive? ? :z_pos : :z_neg
            quads[x][y][z] += 1
        end
        quads.each do |_x, y|
            y.each do |_y, z|
                z.each { |_z, num| print " - #{num}" }
            end
        end
    end
end

# example = parse(EXAMPLE)
# print_quadrant_count(example)

data = parse(DATA)
print_quadrant_count(data)
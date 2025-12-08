module Aoc
  module Year2025
    class Day08
      def self.example_input
        <<~INPUT.strip
          162,817,812
          57,618,57
          906,360,560
          592,479,940
          352,342,300
          466,668,158
          542,29,236
          431,825,988
          739,650,466
          52,470,668
          216,146,977
          819,987,18
          117,168,530
          805,96,715
          346,949,466
          970,615,88
          941,993,340
          862,61,35
          984,92,344
          425,690,689 
        INPUT
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      Point = Data.define(:x, :y, :z)

      def parse(input)
        input.strip.lines.map do |row|
          Point.new(*row.strip.split(',').map(&:to_i))
        end
      end

      def to_key(point)
        "#{point.x},#{point.y},#{point.z}"
      end

      def distance_between(point_a, point_b)
        Math.sqrt((point_b.x - point_a.x) ** 2 +
          (point_b.y - point_a.y) ** 2 +
          (point_b.z - point_a.z) ** 2)
      end

      Distance = Data.define(:a, :b, :distance)

      def part_one(input, pairs: 1000)
        junction_boxes = parse(input).sort_by { to_key(it) }

        distances = find_distances(junction_boxes)

        circuit_assignments = assign_to_separate_circuits(junction_boxes)

        pairs.times do
          distance = distances.shift
          circuit_assignments = connect_junction_boxes(circuit_assignments, distance.a, distance.b)
        end

        circuit_assignments.values.tally.values.sort.last(3).reduce(&:*)
      end

      def find_distances(points)
        distances = []
        points.each_with_index do |point, index|
          points.drop(index + 1).each do |other_point|
            distance = distance_between(point, other_point)
            distances.append(Distance.new(point, other_point, distance))
          end
        end

        distances.sort_by(&:distance)
      end

      def assign_to_separate_circuits(points)
        points.each_with_object({}).with_index do |point_circuit_assignments, index|
          point = point_circuit_assignments.first
          circuit_assignments = point_circuit_assignments.last

          circuit_assignments[to_key(point)] = index
        end
      end

      def connect_junction_boxes(circuit_assignments, a, b)
        return circuit_assignments if circuit_assignments[to_key(a)] == circuit_assignments[to_key(b)]

        old_circuit = circuit_assignments[to_key(b)]
        new_circuit = circuit_assignments[to_key(a)]
        circuit_assignments.each do |key, value|
          circuit_assignments[key] = new_circuit if value == old_circuit
        end

        circuit_assignments
      end

      def part_two(input)
        junction_boxes = parse(input).sort_by { to_key(it) }

        distances = find_distances(junction_boxes)

        circuits = assign_to_separate_circuits(junction_boxes)

        until circuits.values.uniq.count == 1
          distance = distances.shift
          circuits = connect_junction_boxes(circuits, distance.a, distance.b)
        end

        distance.a.x * distance.b.x
      end
    end
  end
end

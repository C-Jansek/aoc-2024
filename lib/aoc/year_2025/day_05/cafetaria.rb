module Aoc
  module Year2025
    class Day05
      def self.example_input
        <<~INPUT.strip
          3-5
          10-14
          16-20
          12-18

          1
          5
          8
          11
          17
          32 
        INPUT
      end

      Input = Data.define(:ranges, :ids)
      Range = Data.define(:start, :end)

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      def parse(input)
        split_input = input.strip.split("\n\n")

        ranges = split_input[0].lines.map do |range|
          Range.new(*range.split('-').map(&:to_i))
        end

        ids = split_input[1].lines.map do |id|
          id.strip.to_i
        end

        Input.new(ranges, ids)
      end

      def fresh_ingredient?(fresh_ranges, ingredient_id)
        fresh_ranges.any? { it.start <= ingredient_id && ingredient_id <= it.end }
      end

      def part_one(input)
        parsed = parse(input)

        parsed.ids.count { |id| fresh_ingredient?(parsed.ranges, id) }
      end

      Poi = Data.define(:ingredient_id, :type)

      def part_two(input)
        ranges = parse(input).ranges

        pois = ranges.flat_map do |range|
          [Poi.new(range.start, :start), Poi.new(range.end, :end)]
        end
        pois.sort_by! { it.ingredient_id + (it.type == :end ? 0.5 : 0) }

        fresh_id_count = 0
        active_range_count = 0
        start_from = nil
        pois.each do |poi|
          if poi.type == :start
            active_range_count += 1

            # First active range, means start counting here
            if active_range_count == 1
              start_from = poi.ingredient_id
            end
          elsif poi.type == :end
            active_range_count -= 1

            # No longer a range active, means stop counting here
            if active_range_count.zero?
              fresh_id_count += (poi.ingredient_id - start_from) + 1
              start_from = nil
            end
          end
        end

        fresh_id_count
      end
    end
  end
end

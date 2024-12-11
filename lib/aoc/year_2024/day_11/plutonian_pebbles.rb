module Aoc
  module Year2024
    class Day11
      def self.example_input
        <<-MSG.strip
          125 17
        MSG
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      def parse(input)
        input.strip.split(' ').map(&:to_i)
      end

      def blink_for_stone(stone)
        @blink_for_stone ||= {}
        @blink_for_stone[stone] ||= begin
                                      if stone == 0
                                        [1]
                                      elsif stone.to_s.split('').count.even?
                                        halfway = stone.to_s.length / 2
                                        [
                                          stone.to_s.split('')[0...halfway].join('').to_i,
                                          stone.to_s.split('')[halfway..-1].join('').to_i
                                        ]
                                      else
                                        [stone * 2024]
                                      end
                                    end
      end

      def blink(stones, times)
        number_with_count = stones.group_by(&:itself).transform_values(&:count)

        times.times do
          number_with_count = number_with_count.each_with_object({}) do |(number, count), number_with_new_count|
            blink_for_stone(number).each do |new_number|
              number_with_new_count[new_number] = number_with_new_count.fetch(new_number, 0) + count
            end
          end
        end

        number_with_count
      end

      def part_one(input)
        stones = parse(input)

        blink(stones, 25).sum(&:last)
      end

      def part_two(input)
        stones = parse(input)

        blink(stones, 75).sum(&:last)
      end
    end
  end
end

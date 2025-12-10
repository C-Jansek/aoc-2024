module Aoc
  module Year2025
    class Day10
      def self.example_input
        <<~INPUT.strip
          [.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
          [...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}
          [.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5} 
        INPUT
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      Machine = Data.define(:indicator_lights, :wirings, :joltages)

      def parse(input)
        input.strip.lines.map do |row|
          indicator_lights = row.strip.match(/\[(.*)\]/)[1].split('').map do |indicator|
            indicator == "#"
          end
          wirings = row.strip.split('] ')[1].split(' {')[0].split(' ').map do |button|
            button.slice(1...-1).split(',').map(&:to_i)
          end
          joltages = row.strip.match(/{(.*)}/)[1].split(',').map(&:to_i)
          Machine.new(indicator_lights, wirings, joltages)
        end
      end

      def self.indicator_lights_button_presses_required(machine)
        light_configs = [machine.indicator_lights.map { false }]
        (1..machine.wirings.count).each do |pressed|
          light_configs = light_configs.flat_map do |previous_config|
            new_mappings = machine.wirings.map do |button|
              previous_config.map.with_index do |prev, index|
                prev && !(button.include?(index)) || !prev && button.include?(index)
              end
            end

            return pressed if new_mappings.any? { it == machine.indicator_lights }

            new_mappings
          end.uniq
        end
      end

      def part_one(input)
        parse(input).sum { self.class.indicator_lights_button_presses_required(it) }
      end

      def self.joltage_button_presses_required(machine)
        goal = machine.joltages

        seen = []
        joltages = [machine.joltages.map { 0 }]
        (1..machine.joltages.sum).each do |pressed|
          joltages = joltages.flat_map do |previous_config|
            new_mappings = machine.wirings.map do |button|
              previous_config.map.with_index do |prev, index|
                if button.include?(index)
                  prev + 1
                else
                  prev
                end
              end
            end

            return pressed if new_mappings.any? { it == goal }

            unseen = new_mappings.reject { seen.include?(it) }
            seen += unseen
            unseen
          end.uniq
        end
      end

      def part_two(input)
        parse(input).each_with_index.sum { |machine, index| puts index; self.class.joltage_button_presses_required(machine) }
      end
    end
  end
end

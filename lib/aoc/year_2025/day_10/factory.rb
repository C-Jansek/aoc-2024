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

      LinearCombination = Data.define(:ws, :total)

      def self.joltage_button_presses_required(machine)
        goal = machine.joltages
        puts
        puts "Goal: #{goal}"

        machine.wirings.each_with_index do |button, index|
          puts "W#{index}: #{(0...machine.joltages.count).map { button.include?(it) ? 1 : 0 }.inspect}"
        end

        lcs = machine.joltages.each_with_index.map do |joltage, index|
          puts machine.wirings.each_with_index.filter_map { |button, w| "W#{w}" if button.include?(index) }.join(" + ") + " = #{joltage}"
          wirings = machine.wirings.each_with_index.filter_map { |button, w| w if button.include?(index) }
          LinearCombination.new(wirings, joltage)
        end

        while true
          new_lcs = []
          lcs.each do |a|
            lcs.each do |b|
              next if a == b

              subs = a.ws - b.ws
              if subs.size == a.ws.size - b.ws.size
                new_lcs << LinearCombination.new(subs, a.total - b.total)
              end
            end
          end
          break if (lcs + new_lcs).uniq.size == lcs.uniq.size

          lcs = (lcs + new_lcs).uniq
        end

        puts "final: (expected until W#{machine.wirings.count - 1})"
        puts lcs.select { it.ws.count == 1 }.map { print_lc(it) }.sort

        complete = lcs.select { it.ws.count == 1 }.count == machine.wirings.count
        puts "total (#{complete}):"
        total = lcs.select { it.ws.count == 1 }.map(&:total).sum
        puts total

        [total, complete]
      end

      def self.print_lc(lc)
        lc.ws.map { "W#{it}" }.join(' + ') + " = " + lc.total.to_s
      end

      def part_two(input)
        result = parse(input).map { |machine| self.class.joltage_button_presses_required(machine) }
        puts result.map(&:inspect)
        puts parse(input).count{ it.wirings.count <= it.joltages.count}
        if result.all?(&:last)
          result.sum(&:first)
        else
          -result.count(&:last)
        end
      end
    end
  end
end

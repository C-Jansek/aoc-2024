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

      Combination = Data.define(:count, :totals, :distance_left)
      LinearCombination = Data.define(:ws, :total)

      def self.joltage_button_presses_required(machine)
        goal = machine.joltages
        unseen = [Combination.new(0, machine.joltages.map { 0 }, distance_left(machine.joltages.map { 0 }, goal))]
        max_distance_per_step = machine.wirings.map { it.sum ** (1 / machine.joltages.count.to_f) }.max

        puts
        puts "Start: #{unseen.first.totals}"
        puts "Go: #{goal}"

        machine.wirings.each_with_index do |button, index|
          puts "W#{index}: #{(0...machine.joltages.count).map { button.include?(it) ? 1 : 0 }.inspect}"
        end

        lcs = machine.joltages.each_with_index.map do |joltage, index|
          puts machine.wirings.each_with_index.filter_map { |button, w| "W#{w}" if button.include?(index) }.join(" + ") + " = #{joltage}"
          wirings = machine.wirings.each_with_index.filter_map { |button, w| w if button.include?(index) }
          LinearCombination.new(wirings, joltage)
        end

        80.times do |index|
          new_lcs = []
          lcs.each do |a|
            lcs.each do |b|
              next if a == b

              subs = a.ws - b.ws
              if subs.size == a.ws.size - b.ws.size
                new_lcs << LinearCombination.new(subs, a.total - b.total)
              end
              #
              # adds = a.ws & b.ws
              # if adds.size == a.ws.size + b.ws.size
              #   new_lcs << LinearCombination.new(subs, a.total + b.total)
              # end
            end
          end
          break if (lcs + new_lcs).uniq.size == lcs.uniq.size

          lcs = (lcs + new_lcs).uniq

          # puts
          # puts "round #{index}"
          # puts lcs.map { print_lc(it) }
        end

        puts "final: (expected until W#{machine.wirings.count - 1})"
        complete = lcs.select { it.ws.count == 1 }.count == machine.wirings.count
        if complete
          puts "completed!"
        else
          puts "INCOMPLETE!"
        end
        puts lcs.select { it.ws.count == 1 }.map { print_lc(it) }.sort

        puts "total:"
        total = lcs.select { it.ws.count == 1 }.map(&:total).sum
        puts total

        [total, complete]
        # while true
        #   current = unseen.shift
        #
        #   return current.count if current.totals == goal
        #   puts [current.count, current.totals, current.distance_left].inspect if rand(100) % 85 == 0
        #
        #   next_combinations = generate_next(current, machine.wirings, goal)
        #   possible_combinations = next_combinations.reject { impossible(it.totals, goal) }.reject { unseen.include?(it) }
        #   unseen.push(*possible_combinations)
        #   unseen = unseen.uniq.sort_by { [it.distance_left + max_distance_per_step * it.count.to_f] }
        # end
      end

      def self.print_lc(lc)
        lc.ws.map { "W#{it}" }.join(' + ') + " = " + lc.total.to_s
      end

      def self.distance_left(totals, goal)
        totals.zip(goal).map do |t, g|
          g - t
        end.reduce do |result, current|
          result + current ** 2
        end ** (1 / 2.to_f)
      end

      def self.generate_next(combination, wirings, goal)
        wirings.map do |wiring|
          totals = combination.totals.each_with_index.map do |total, index|
            if wiring.include?(index)
              total + 1
            else
              total
            end
          end

          # puts({ totals: totals, goal: goal, distance: impossible(totals, goal) ? 10E100 : distance_left(totals, goal) })
          Combination.new(
            combination.count + 1,
            totals,
            impossible(totals, goal) ? 10E100 : distance_left(totals, goal)
          )
        end
      end

      def self.impossible(totals, goal)
        totals.zip(goal).any? do |total, g|
          total > g
        end
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

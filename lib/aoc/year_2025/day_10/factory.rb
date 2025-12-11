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

        lcs = simplify_lcs(lcs)

        puts "final: (expected until W#{machine.wirings.count - 1})"
        # puts lcs.select { it.ws.count == 1 }.map { print_lc(it) }.sort
        puts lcs.map { print_lc(it) }.sort
        return lcs.sum { it.total } if lcs.select { it.ws.count == 1 }.count == machine.wirings.count

        solve_lcs(lcs, (0...machine.wirings.count), machine.joltages, machine.wirings)

        # complete = lcs.select { it.ws.count == 1 }.count == machine.wirings.count
        # puts "total (#{complete}):"
        # total = lcs.select { it.ws.count == 1 }.map(&:total).sum
        # puts total
        #
        # [total, complete]
      end

      def self.simplify_lcs(lcs)
        while true
          new_lcs = []
          remove_lcs = []
          lcs.each do |a|
            lcs.each do |b|
              next if a == b

              subs = a.ws - b.ws
              if subs.size == a.ws.size - b.ws.size
                remove_lcs << a
                new_lcs << LinearCombination.new(subs, a.total - b.total)
              end
            end
          end
          break if (lcs + new_lcs).uniq.size == lcs.uniq.size

          lcs = (lcs + new_lcs).uniq - remove_lcs
        end

        lcs
      end

      Equality = Data.define(:other_weight, :plus)

      def self.print_eq(equality)
        "W#{equality.other_weight} + #{equality.plus}"
      end

      def self.print_things_we_know(twk)
        twk = twk.each_with_object([]) { |(key, value), array| hash = { "W": key.to_s }; value.each { |k, v| hash[k] = v }; array.append(hash) }
        col_labels = twk.first.each_with_object({}) { |(key, _value), hash| hash[key] = key }
        @columns = col_labels.each_with_object({}) { |(col, label), h|
          h[col] = { label: label,
                     width: [twk.map do |g|
                       string = if g[col].is_a?(Array) && g[col].first.is_a?(Equality)
                                  g[col].map { print_eq(it) }
                                else
                                  g[col]
                                end
                       (string || "").size
                     end.max, label.size].max } }

        write_header = ->() {
          puts "| #{ @columns.map { |_, g| g[:label].to_s.ljust(g[:width]) }.join(' | ') } |"
        }

        write_divider = ->() {
          puts "+-#{ @columns.map { |_, g| "-" * g[:width] }.join("-+-") }-+"
        }

        write_line = -> (h) {
          str = h.keys.map do |k|
            value = h[k]
            string = if value.is_a?(Array) && value.first.is_a?(Equality)
                       value.map { print_eq(it) }
                     else
                       value
                     end
            string.to_s.ljust(@columns[k][:width])
          end.join(" | ")
          puts "| #{str} |"
        }

        write_divider.call
        write_header.call
        write_divider.call
        twk.each { |h| write_line.call(h) }
        write_divider.call
      end

      def self.solve_lcs(lcs, weights, target, wirings)
        things_we_know = weights.each_with_object({}) do |weight, things_we_know|
          min = lcs.find { |lc| lc.ws == [weight] }&.total || 0
          max = lcs.filter { |lc| lc.ws.include?(weight) }.sum { |lc| lc.total }
          things_we_know[weight] = {
            min: min,
            max: max,
            actual: min == max ? min : nil,
            equalities: []
          }
        end

        lcs.each do |a|
          lcs.each do |b|
            next if a == b

            intersection = a.ws & b.ws
            if (a.ws - intersection).count == 1 && (b.ws - intersection).count == 1
              a_bigger_than_b = a.total - b.total

              if a_bigger_than_b > 0
                weight_a = (a.ws - intersection).first
                weight_b = (b.ws - intersection).first

                things_we_know[weight_a][:equalities] = things_we_know[weight_a].fetch(:equalities, []).append(Equality.new(weight_b, a_bigger_than_b)).uniq
              end
            end
          end
        end

        puts print_things_we_know(things_we_know)

        10.times do
          things_we_know = update_things_we_know(things_we_know)
        end

        puts print_things_we_know(things_we_know)

        still_to_try = [Guess.new(things_we_know.each_pair.map { it.last[:min] }, things_we_know.each_pair.map { it.last[:min] }.sum, things_we_know)]

        count = 0
        while true
          count += 1
          try_out = still_to_try.shift
          if count % 50 == 0
            puts "Gap left: #{try_out.things_we_know.each_pair.map { it.last[:max] - it.last[:min] }.sum}"
            puts print_things_we_know(try_out.things_we_know)
          end
          # puts "#{still_to_try.count}: Try out #{try_out}"
          potentials = generate_new_tries(try_out)
          # puts "New guesses: ", potentials.map(&:try).map(&:inspect)
          potentials = potentials.filter { valid_guess?(it) }
          # puts "Filtered guesses: #{potentials.inspect}"

          if (actual = potentials.find { found?(it, target, wirings) })
            return actual.sum
          end

          still_to_try += potentials
          still_to_try = still_to_try.uniq.sort_by { |guess| guess.things_we_know.each_pair.map { it.last[:max] - it.last[:min] }.sum }
        end
      end

      def self.found?(guess, target, wirings)
        puts wirings.inspect
        puts guess.try.inspect
        puts target.inspect
        joltages = guess.try.each_with_index.with_object(target.map { 0 }) do |(press_count, button_index), array|
          wirings[button_index].each do |counter_index|
            array[counter_index] += press_count
          end
        end
        puts joltages.inspect
        joltages == target
        raise StandardError
      end

      Guess = Data.define(:try, :total_presses, :things_we_know)

      def self.update_things_we_know(things_we_know)
        things_we_know.each_pair do |weight, knowledge|
          next if knowledge[:equalities].empty?

          knowledge[:equalities].each do |equality|
            other_knowledge = things_we_know[equality.other_weight]

            things_we_know[equality.other_weight][:min] = [knowledge[:min] - equality.plus, 0, other_knowledge[:min]].max
            things_we_know[equality.other_weight][:max] = (knowledge[:max] - equality.plus).clamp(0, other_knowledge[:max])
            things_we_know[equality.other_weight][:actual] = if things_we_know[equality.other_weight][:min] == things_we_know[equality.other_weight][:max]
                                                               things_we_know[equality.other_weight][:max]
                                                             else
                                                               nil
                                                             end

            things_we_know[weight][:min] = [things_we_know[weight][:min], other_knowledge[:min] + equality.plus].max
            things_we_know[weight][:max] = (other_knowledge[:max] + equality.plus).clamp(0, knowledge[:max])

          end
        end
      end

      def self.generate_new_tries(last_guess)
        last_guess.try.each_with_index.map do |_button, index|
          things_we_know = Marshal.load(Marshal.dump(last_guess.things_we_know))
          things_we_know[index][:min] += 1
          things_we_know = update_things_we_know(things_we_know)
          Guess.new(things_we_know.each_pair.map { it.last[:min] }, things_we_know.each_pair.map { it.last[:min] }.sum, things_we_know)
        end
      end

      def self.valid_guess?(guess)
        guess.try.each_with_index.all? do |presses, button_index|
          knowledge = guess.things_we_know[button_index]

          return false if !knowledge[:actual].nil? && presses != knowledge[:actual]
          return false if presses < knowledge[:min]
          return false if presses > knowledge[:max]

          true
        end
      end

      def self.print_lc(lc)
        lc.ws.map { "W#{it}" }.join(' + ') + " = " + lc.total.to_s
      end

      def part_two(input)
        result = parse(input).map { |machine| self.class.joltage_button_presses_required(machine) }
        puts result.map(&:inspect)
        puts parse(input).count { it.wirings.count <= it.joltages.count }
        if result.all?(&:last)
          result.sum(&:first)
        else
          -result.count(&:last)
        end
      end
    end
  end
end

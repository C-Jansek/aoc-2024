module Aoc
  module Year2024
    class Day19
      def self.example_input
        <<-INPUT.strip
          r, wr, b, g, bwu, rb, gb, br

          brwrr
          bggr
          gbbr
          rrbgbr
          ubwu
          bwurrg
          brgr
          bbrgwb
        INPUT
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      def parse(input)
        towels_input, stacks_input = input.strip.split(/\n\s*\n/)[0..1]

        towels = towels_input.strip.split(',').map(&:strip)
        stacks = stacks_input.strip.lines.map(&:strip)
        {
          towels: towels,
          stacks: stacks
        }
      end

      def self.stack_possible(stack, towels, count: false)
        towels = towels.filter do |towel|
          stack.match?(towel)
        end

        matching_until = -> (potential) do
          potential == stack[0...potential.length]
        end

        filtered_stacks = towels.filter(&matching_until)
        seen = {}
        filtered_stacks.each do |filtered_stack|
          seen[filtered_stack] = 1
        end

        stack.length.times do |index|
          seen_stacks_of_length_n = seen.keys.filter do |key|
            key.length == index
          end

          seen_stacks_of_length_n.each do |stack_of_length_n|
            towels.map do |towel|
              new_stack = stack_of_length_n + towel

              next unless matching_until.call(new_stack)
              return true if !count && new_stack == stack

              seen[new_stack] = seen.fetch(new_stack, 0) + seen[stack_of_length_n]
            end
          end
        end

        return false unless count

        seen.fetch(stack, 0)
      end

      def part_one(input)
        parsed = parse(input)

        towels = parsed[:towels]
        stacks = parsed[:stacks]

        stacks.count do |stack|
          Day19.stack_possible(stack, towels)
        end
      end

      def part_two(input)
        parsed = parse(input)

        towels = parsed[:towels]
        stacks = parsed[:stacks]

        stacks.sum do |stack|
          Day19.stack_possible(stack, towels, count: true)
        end
      end
    end
  end
end

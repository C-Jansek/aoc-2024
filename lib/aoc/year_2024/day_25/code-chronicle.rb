module Aoc
  module Year2024
    class Day25
      def self.example_input
        <<~INPUT.strip
          #####
          .####
          .####
          .####
          .#.#.
          .#...
          .....

          #####
          ##.##
          .#.##
          ...##
          ...#.
          ...#.
          .....

          .....
          #....
          #....
          #...#
          #.#.#
          #.###
          #####

          .....
          .....
          #.#..
          ###..
          ###.#
          ###.#
          #####

          .....
          .....
          .....
          #....
          #.#..
          #.#.#
          ##### 
        INPUT
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      def parse(input)
        input.strip.split("\n\n").map do |key_or_lock|
          key_or_lock.split.map { it.split('') }
        end.partition do |chars|
          lock?(chars)
        end.map do |locks_or_keys|
          locks_or_keys.map do |key_or_lock|
            key_or_lock.transpose.map { it.count('#') - 1 }
          end
        end
      end

      HEIGHT = 5

      def part_one(input)
        parsed = parse(input)
        locks = parsed.first
        keys = parsed.last

        keys.sum do |key|
          locks.count do |lock|
            key.zip(lock).all? { |pin, socket| pin + socket <= HEIGHT }
          end
        end
      end

      def lock?(key_or_lock)
        key_or_lock.first.all? { it == "#" } && key_or_lock.last.all? { it == "." }
      end
    end
  end
end

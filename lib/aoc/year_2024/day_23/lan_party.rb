module Aoc
  module Year2024
    class Day23
      def self.example_input
        <<-INPUT.strip
          kh-tc
          qp-kh
          de-cg
          ka-co
          yn-aq
          qp-ub
          cg-tb
          vc-aq
          tb-ka
          wh-tc
          yn-cg
          kh-ub
          ta-co
          de-co
          tc-td
          tb-wq
          wh-td
          ta-ka
          td-qp
          aq-cg
          wq-ub
          ub-vc
          de-ta
          wq-aq
          wq-vc
          wh-yn
          ka-de
          kh-ta
          co-tc
          wh-qp
          tb-vc
          td-yn
        INPUT
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      def parse(input)
        input.strip.lines.each_with_object({}) do |line, connected_to|
          a, b = line.strip.split('-', 2)
          connected_to[a] = Set.new unless connected_to.key?(a)
          connected_to[a] << b

          connected_to[b] = Set.new unless connected_to.key?(b)
          connected_to[b] << a
        end
      end

      def part_one(input)
        connected_to = parse(input)

        connected_to.filter do |from, _to|
          from[0] == 't'
        end.map do |from, to_all|
          to_all.map do |to|
            connected_to[to].map do |third|
              next nil unless connected_to[from].include?(third)
              [from, to, third].sort
            end
          end
        end.flatten(2).compact.uniq.count
      end

      def part_two(input)
        parsed = parse(input)

        nil
      end
    end
  end
end

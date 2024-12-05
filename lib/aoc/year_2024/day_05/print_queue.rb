module Aoc
  module Year2024
    class Day05
      def self.example_input
        <<-MSG.strip
          47|53
          97|13
          97|61
          97|47
          75|29
          61|13
          75|53
          29|13
          97|29
          53|29
          61|53
          97|53
          61|29
          47|13
          75|47
          97|75
          47|61
          75|61
          47|29
          75|13
          53|13
          
          75,47,61,53,29
          97,61,53,29,13
          75,29,13
          75,97,47,61,53
          61,13,29
          97,13,75,29,47
        MSG
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      def parse(input)
        page_ordering_rules_input, updates_input = input.strip.split(/\n\s*\n/, 2)

        page_ordering_rules = page_ordering_rules_input.lines.map do |line|
          line.strip.split('|', 2).map(&:to_i)
        end

        updates = updates_input.lines.map do |line|
          line.strip.split(',').map(&:to_i)
        end

        { page_ordering_rules: page_ordering_rules, updates: updates }
      end

      def update_ordered?(update, page_ordering_rules)
        page_ordering_rules.all? do |page_ordering_rule|
          page_before_index = update.index(page_ordering_rule[0])
          page_after_index = update.index(page_ordering_rule[1])

          next true if page_before_index.nil? || page_after_index.nil?

          return false if page_before_index > page_after_index

          next true
        end
      end

      def order_update(update, page_ordering_rules)
        applicable_rules = page_ordering_rules.select do |page_ordering_rule|
          update.any? do |page|
            page_ordering_rule.include?(page)
          end
        end

        update.sort do |a, b|
          rule = applicable_rules.find do |page_ordering_rule|
            page_ordering_rule.include?(a) && page_ordering_rule.include?(b)
          end

          next 0 if rule.nil?

          next -1 if a == rule[0]
          next 1
        end
      end

      def part_one(input)
        parsed = parse(input)
        page_ordering_rules = parsed.dig(:page_ordering_rules)
        updates = parsed.dig(:updates)

        updates.select do |update|
          update_ordered?(update, page_ordering_rules)
        end.map do |update|
          update[(update.length - 1) / 2]
        end.sum
      end

      def part_two(input)
        parsed = parse(input)
        page_ordering_rules = parsed.dig(:page_ordering_rules)
        updates = parsed.dig(:updates)

        updates.reject do |update|
          update_ordered?(update, page_ordering_rules)
        end.map do |update|
          order_update(update, page_ordering_rules)
        end.map do |update|
          update[(update.length - 1) / 2]
        end.sum
      end
    end
  end
end

module Aoc
  module Year2024
    class Day07
      def self.example_input
        <<-MSG.strip
          190: 10 19
          3267: 81 40 27
          83: 17 5
          156: 15 6
          7290: 6 8 6 15
          161011: 16 10 13
          192: 17 8 14
          21037: 9 7 18 13
          292: 11 6 16 20
        MSG
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      def parse(input)
        input.strip.lines.map do |line|
          answer, numbers = line.strip.split(': ', 2)
          {
            answer: answer.strip.to_i,
            numbers: numbers.split(' ').map(&:to_i)
          }
        end
      end

      def self.answerable(expected_answer, numbers, concatenation_allowed = false)
        answers = [numbers.first]
        numbers[1..].each do |number|
          multiplied = answers.map do |answer|
            answer * number
          end
          summed = answers.map do |answer|
            answer + number
          end
          concatenation = if concatenation_allowed
                            answers.map do |answer|
                              (answer.to_s + number.to_s).to_i
                            end
                          else
                            []
                          end
          answers = (multiplied + summed + concatenation).uniq
        end
        answers.include?(expected_answer)
      end

      def part_one(input)
        parsed = parse(input)

        parsed.map do |equation|
          equation.dig(:answer) if Day07.answerable(equation.dig(:answer), equation.dig(:numbers))
        end.reject(&:nil?).sum
      end

      def part_two(input)
        parsed = parse(input)

        parsed.map do |equation|
          equation.dig(:answer) if Day07.answerable(equation.dig(:answer), equation.dig(:numbers), true)
        end.reject(&:nil?).sum
      end
    end
  end
end

module Aoc
  module Year2025
    class Day11
      def self.example_input
        <<~INPUT.strip
          aaa: you hhh
          you: bbb ccc
          bbb: ddd eee
          ccc: ddd eee fff
          ddd: ggg
          eee: out
          fff: out
          ggg: out
          hhh: ccc fff iii
          iii: out          
        INPUT
      end

      def self.example_input_part_two
        <<~INPUT.strip
          svr: aaa bbb
          aaa: fft
          fft: ccc
          bbb: tty
          tty: ccc
          ccc: ddd eee
          ddd: hub
          hub: fff
          eee: dac
          dac: fff
          fff: ggg hhh
          ggg: out
          hhh: out
        INPUT
      end

      Node = Data.define(:id, :towards)

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      def parse(input)
        input.strip.lines.map do |row|
          id = row.strip.split(':')[0]
          towards = row.strip.split(':')[1].strip.split(' ')
          Node.new(id, towards)
        end
      end

      def part_one(input)
        nodes = parse(input)
        nodes.append(Node.new('out', ['out']))

        current_nodes_with_counts = {
          "you": 1
        }

        until current_nodes_with_counts.keys == ['out']
          current_nodes_with_counts = current_nodes_with_counts.each_pair.each_with_object({}) do |(id, count), new_nodes_with_counts|
            nodes.find { it.id == id.to_s }.towards.each do |new_id|
              new_nodes_with_counts[new_id] = new_nodes_with_counts.fetch(new_id, 0) + count
            end
          end
        end

        current_nodes_with_counts['out']
      end

      def part_two(input)
        nodes = parse(input)
        nodes.append(Node.new('out', ['out']))

        current_nodes_with_counts = {
          "svr": {
            "": 1
          }
        }
        visit_all = ['dac', 'fft']

        until current_nodes_with_counts.keys == ['out']
          current_nodes_with_counts = current_nodes_with_counts.each_pair.each_with_object({}) do |(id, count_and_if_visited), new_nodes_with_counts|
            extra_visit = visit_all.find{ it == id.to_s }

            nodes.find { it.id == id.to_s }.towards.each do |new_id|
              count_and_if_visited.each_pair do |visited, count|
                updated = visited.to_s.split('_').concat([extra_visit]).compact.sort.join('_')
                new_nodes_with_counts[new_id] ||= {}
                new_nodes_with_counts[new_id][updated] = new_nodes_with_counts.fetch(new_id, {}).fetch(updated, 0) + count
              end
            end
          end
        end

        current_nodes_with_counts['out'][visit_all.sort.join('_')]
      end
    end
  end
end

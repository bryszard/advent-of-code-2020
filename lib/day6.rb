class Day6
  class << self
    def count_group_answers_1(input)
      groups = input.split("\n\n")

      groups.map { |group| count_all_questions(group) }.sum
    end

    def count_group_answers_2(input)
      groups = input.split("\n\n")

      groups.map { |group| count_same_questions(group) }.sum
    end

    def count_all_questions(input)
      input.split("\n").join.chars.uniq.count
    end

    def count_same_questions(input)
      single_person_answers = input.split("\n").map(&:chars)

      single_person_answers.inject(single_person_answers.first) do |aggr, answers|
        aggr & answers
      end.count
    end
  end
end

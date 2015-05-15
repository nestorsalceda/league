module League
  POINTS_PER_VICTORY = 3
  ClassificationEntry = Struct.new('ClassificationEntry', :team, :points)

  class ClassificationService

    def calculate_classification(teams, matches)
      classification = empty_classification_for(teams)

      matches.each do |match|
        if match.has_been_played?
          classification[match.winner].points += POINTS_PER_VICTORY
        end
      end

      classification.values.sort_by{ |team| team.points }.reverse!
    end

    private

    def empty_classification_for(teams)
      classification = {}
      teams.each do |team|
        classification[team] = ClassificationEntry.new(team, 0)
      end
      classification
    end
  end
end

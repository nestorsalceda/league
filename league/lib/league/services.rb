module League
  POINTS_PER_VICTORY = 3
  ClassificationEntry = Struct.new('ClassificationEntry', :team, :points)

  class ClassificationService
    def classification_for(group, competition)
      classification = {}
      group.teams.each do |team|
        classification[team] = ClassificationEntry.new(team, 0)
      end

      competition.journeys.each do |journey|
        journey.matches.each do |match|
          if group.include? match.local
            if match.winner == match.local
              classification[match.local].points += POINTS_PER_VICTORY
            end
            if match.winner == match.visitor
              classification[match.visitor].points += POINTS_PER_VICTORY
            end
          end
        end
      end

      classification.values.sort_by{ |team| team.points }.reverse!
    end
  end
end

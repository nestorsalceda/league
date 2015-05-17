module League
  POINTS_PER_VICTORY = 3
  ClassificationEntry = Struct.new('ClassificationEntry', :team, :points, :played_games, :scored)

  class ClassificationService

    def calculate_classification(teams, matches)
      classification = empty_classification_for(teams)

      matches.each do |match|
        if match.has_been_played?
          #TODO: Filter matches by teams parameters
          if classification.include? match.winner
            classification[match.winner].points += POINTS_PER_VICTORY

            classification[match.local].played_games += 1
            classification[match.visitor].played_games += 1

            classification[match.local].scored += match.local_result
            classification[match.visitor].scored += match.visitor_result
          end
        end
      end

      classification.values.sort_by{ |team| team.points }.reverse!
    end

    private

    def empty_classification_for(teams)
      classification = {}
      teams.each do |team|
        classification[team] = ClassificationEntry.new(team, 0, 0, 0)
      end
      classification
    end
  end
end

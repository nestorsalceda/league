module LigaFutbolin
  POINTS_PER_VICTORY = 3
  ClassificationEntry = Struct.new('ClassificationEntry', :team, :points)

  class ClassificationService
    def initialize(*teams)
       @teams = teams
    end

    def classification
      results = @teams.map do |team|
        points = 0
        team.results.each do |result|
          if result.result_local > result.result_visitor
            points += POINTS_PER_VICTORY
          end
        end
        ClassificationEntry.new(team, points)
      end

      results.sort_by{ |team| team.points }.reverse!
    end
  end
end

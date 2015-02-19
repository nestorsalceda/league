module LigaFutbolin
  POINTS_PER_VICTORY = 3
  ClassificationEntry = Struct.new('ClassificationEntry', :team, :points)

  class ClassificationService
    def initialize(*teams)
       @teams = teams
    end

    def classification
      results = @teams.map{ |team| ClassificationEntry.new(team, points_for(team)) }
      results.sort_by{ |team| team.points }.reverse!
    end

    private

    def points_for(team)
      points = 0
      team.results.each do |result|
        points += POINTS_PER_VICTORY if result.local_won?
      end
      points
    end
  end
end

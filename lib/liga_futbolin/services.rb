module LigaFutbolin
  POINTS_PER_VICTORY = 3
  ClassificationEntry = Struct.new('ClassificationEntry', :team, :points)

  class ClassificationService
    def initialize(match_repository)
       @match_repository = match_repository
    end

    def classification
      results = []
      matches_per_team.each do |team, matches|
        results << ClassificationEntry.new(team, points_for(team, matches))
      end
      results.sort_by{ |team| team.points }.reverse!
    end

    private

    def matches_per_team
      matches = {}

      @match_repository.all.each do |match|
        matches[match.local] = []
        matches[match.visitor] = []
      end

      @match_repository.all.each do |match|
        matches[match.local] << match
        matches[match.visitor] << match
      end

      matches
    end

    def points_for(team, matches)
      points = 0
      matches.each do |match|
        points += POINTS_PER_VICTORY if match.winner == team
      end
      points
    end
  end
end

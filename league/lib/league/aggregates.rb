module League
  class Competition
    attr_reader :name, :groups, :journeys

    def initialize(name)
      @name = name
      @groups = []
      @journeys = []
    end

    def add_group(group)
      @groups << group
    end

    def add_journey(journey)
      @journeys << journey
    end
  end

  class Group
    attr_reader :name, :teams

    def initialize(name)
      @name = name
      @teams = []
    end

    def add_team(team)
      @teams << team
    end

    def include?(team)
      @teams.include?(team)
    end
  end

  class Journey
    attr_reader :date, :matches

    def initialize(date)
      @date = date
      @matches = []
    end

    def add_match(match)
      @matches << match
    end
  end

  class Match
    attr_reader :local, :visitor, :local_result, :visitor_result

    def initialize(local, visitor)
      @local = local
      @visitor = visitor
      @result_local = 0
      @result_visitor = 0
    end

    def result(local, visitor)
      @local_result = local
      @visitor_result = visitor
    end

    def winner
      return nil if local_result == visitor_result
      return local if local_result > visitor_result
      return visitor
    end
  end
end

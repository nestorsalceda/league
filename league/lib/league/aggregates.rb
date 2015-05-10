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
    attr_reader :name

    def initialize(name)
      @name = name
      @teams = []
    end

    def add_team(team)
      @teams << team
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
    attr_reader :local, :visitor

    def initialize(local, visitor)
      @local = local
      @visitor = visitor
    end
  end
end

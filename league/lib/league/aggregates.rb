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

    def all_matches
      journeys.map { |journey| journey.matches }.flatten
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
    attr_reader :local, :visitor

    def initialize(local, visitor, local_result=-1, visitor_result=-1)
      @local = local
      @visitor = visitor
      @local_result = local_result
      @visitor_result = visitor_result
    end

    def result(local, visitor)
      @local_result = local
      @visitor_result = visitor
    end

    def local_result
      return 0 if @local_result == -1
      @local_result
    end

    def visitor_result
      return 0 if @visitor_result == -1
      @visitor_result
    end

    def winner
      return nil if local_result == visitor_result
      return local if local_result > visitor_result
      return visitor
    end

    def has_been_played?
      @local_result != -1 or @visitor_result != -1
    end
  end
end

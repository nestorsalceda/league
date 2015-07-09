module League
  class Competition
    attr_reader :name, :groups, :journeys

    def initialize(args)
      @name = args[:name]
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

    def teams
      groups.map { |group| group.teams }.flatten
    end
  end

  class Team
    attr_reader :name, :location, :hour, :day

    def initialize(args)
      @name = args[:name]
      @location = args[:location]
      @hour = args[:hour]
      @day = args[:day]
    end

    def slug
      name.gsub(' ', '-').downcase
    end

    def to_sym
      name.gsub(' ', '_').downcase.to_sym
    end
  end

  class Group
    attr_reader :name, :teams

    def initialize(args)
      @name = args[:name]
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

    def initialize(args)
      @date = args[:date]
      @matches = []
    end

    def add_match(match)
      @matches << match
    end
  end

  class Match
    attr_reader :local, :visitor

    def initialize(args)
      @local = args[:local]
      @visitor = args[:visitor]
      @local_result = args[:local_result]
      @visitor_result = args[:visitor_result]
    end

    def result(local, visitor)
      @local_result = local
      @visitor_result = visitor
    end

    def local_result
      return 0 if @local_result.nil?
      @local_result
    end

    def visitor_result
      return 0 if @visitor_result.nil?
      @visitor_result
    end

    def winner
      return nil if local_result == visitor_result
      return local if local_result > visitor_result
      return visitor
    end

    def has_been_played?
      not @local_result.nil? and not @visitor_result.nil?
    end
  end
end

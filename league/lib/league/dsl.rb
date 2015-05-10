module League
  class Competition
    attr_reader :name, :journeys

    def initialize(name, &block)
      @name = name
      @teams = {}
      @journeys = []
      instance_eval &block
    end

    def teams
      if block_given?
        teams = yield
        teams.each do |team|
          name = team.gsub(' ', '_').downcase
          @teams[name] = team
          define_singleton_method(name.to_sym) do
            team
          end
        end
      else
        @teams.values
      end
    end

    def journey(date, &block)
      j = Journey.new(date)
      @teams.each do |name, team|
        j.define_singleton_method(name.to_sym) do
          team
        end
      end
      j.instance_eval(&block)
      @journeys << j
    end

  end

  class Journey
    attr_reader :date, :matches

    def initialize(date)
      @date = date
      @matches = []
    end

    def match(local, visitor, &block)
      m = Match.new(local, visitor)
      if block_given?
        m.instance_eval(&block)
      end
      @matches << m
    end
  end

  class Match
    attr_reader :local_team, :visitor_team
    attr_accessor :local_result, :visitor_result

    def initialize(local_team, visitor_team)
      @local_team = local_team
      @visitor_team = visitor_team
      @local_result = nil
      @visitor_result = nil
    end

    def result(local, visitor)
      @local_result = local
      @visitor_result = visitor
    end
  end
end

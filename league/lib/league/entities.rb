module League

  Match = Struct.new(:local, :visitor, :result_local, :result_visitor) do
    def winner
      return local if result_local > result_visitor
      return visitor
    end
  end

  class Team
    attr_reader :name

    def initialize(name)
      @name = name
    end
  end
end

require 'sinatra/base'
require 'slim'

module LigaFutbolin
  class Application < Sinatra::Base
    configure :development do
      require 'sinatra/reloader'

      register Sinatra::Reloader
      also_reload File.join(__dir__, '*.rb')
    end

    def initialize(app=nil)
      super(app)

      @match_repository = MatchRepository.new
      @classification_service = ClassificationService.new(@match_repository)
      seed_data
    end


    def seed_data
      trilogy_a = Team.new('Trilogy A')
      trilogy_b = Team.new('Trilogy B')
      trilogy_c = Team.new('Trilogy C')
      tonel = Team.new('Tonel')

      @match_repository.put(Match.new(trilogy_a, trilogy_b, 7, 13))
      @match_repository.put(Match.new(trilogy_c, tonel, 13, 7))

      @match_repository.put(Match.new(trilogy_a, trilogy_c, 13, 4))
      @match_repository.put(Match.new(trilogy_b, tonel, 13, 4))

      @match_repository.put(Match.new(trilogy_a, tonel, 13, 4))
      @match_repository.put(Match.new(trilogy_b, trilogy_c, 13, 7))
    end

    get '/' do
      classification = @classification_service.classification

      slim :index, layout: :layout, locals: {
        :classification => classification
      }
    end
  end
end

require 'sinatra/base'
require 'slim'

require "league"

module League::Webapp
  class Application < Sinatra::Base
    configure :development do
      require 'better_errors'
      require 'sinatra/reloader'

      register Sinatra::Reloader
      also_reload File.join(__dir__, '**/*.rb')
      also_reload File.join(__dir__, '../league/**/*.rb')

      use BetterErrors::Middleware
      BetterErrors.application_root = __dir__
    end

    def initialize(app=nil)
      super(app)

      @classification_service = League::ClassificationService.new
    end

    get '/:competition' do
      competition = Object.new.instance_eval(File.read("./competitions/#{params['competition']}.rb"))
      #classification = @classification_service.classification(competition)

      slim :index, :locals => {
        :title => competition.name,
        :competition => competition
      }
    end
  end
end

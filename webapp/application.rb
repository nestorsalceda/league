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
      competition = Object.new.instance_eval(File.read(File.join(__dir__, "competitions", "#{params['competition']}.rb")))

      classifications = {}
      competition.groups.each do |group|
        classifications[group] = @classification_service.calculate_classification(group.teams, competition.all_matches)
      end

      slim :index, :locals => {
        :title => competition.name,
        :competition => competition,
        :classifications => classifications
      }
    end
  end
end

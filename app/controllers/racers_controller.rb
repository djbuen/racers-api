class RacersController < ApplicationController
    def index
        racers = Racer.all
        render json: racers, status: :ok
    end
end

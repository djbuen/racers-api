class RacersController < ApplicationController
    def index
        racers = Racer.all
        render json: racers, status: :ok
    end

    def create
    end

    def update
    end

    def destroy
    end
end

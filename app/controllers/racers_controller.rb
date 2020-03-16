class RacersController < ApplicationController
    def index
        racers = Racer.all
        render json: racers, status: :ok
    end

    def create
        flash = {}
        racer = Racer.new racer_params
        if racer.create
            flash[:success] = "Added racer"
        else
            flash[:error] = "Unable to add racer"
        end
        render json: flash, status: :ok
    end

    def update
    end

    def destroy
    end

    private

    def racer_params
        params.require(:racer).permit :first_name, :last_name
    end
end

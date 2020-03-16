class RacersController < ApplicationController
    include Response
    def index
        racers = Racer.all
        json_response(racers)
    end

    def create
        flash = {}
        racer = Racer.new racer_params
        if racer.create
            flash[:success] = "Added racer"
            status = :ok
        else
            flash[:error] = "Unable to add racer"
            status = :expectation_failed
        end
        json_response(flash, status)
    end

    def update
        flash = {}
        racer = Racer.find params[:id]
        if racer&.update racer_params
            flash[:success] = "Updated racer"
            status = :ok
        else
            flash[:error] = "Unable to update racer"
            status = :expectation_failed
        end
        json_response(flash, status)
    end

    def destroy
        flash = {}
        racer = Racer.find params[:id]
        if racer&.delete
            flash[:success] = "Deleted racer"
            status = :ok
        else
            flash[:error] = "Unable to delete racer"
            status = :expectation_failed
        end
        json_response(flash, status)
    end

    private

    def racer_params
        params.require(:racer).permit :first_name, :last_name
    end
end

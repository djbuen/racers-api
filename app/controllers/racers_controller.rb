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
            status = :ok
        else
            flash[:error] = "Unable to add racer"
            status = :expectation_failed
        end
        render json: flash, status: status
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
        render json: flash, status: status
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
        render json: flash, status: status
    end

    private

    def racer_params
        params.require(:racer).permit :first_name, :last_name
    end
end

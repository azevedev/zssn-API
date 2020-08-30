class Api::V1::ReportsController < ApplicationController
    
    def create
        params.require(:id)
        @survivor = find(params[:id])
        if !@survivor.nil?
            @survivor.reports += 1
            if(@survivor.reports >= 3)
                @survivor.infected = true
            end
            if @survivor.save 
                head :no_content
            else
                render json: @survivor.errors, status: :unprocessable_entity
            end
        else  
            render json: {"error" => "Survivor #{params[:id]} not found"}, status: :not_found
        end
    end

    def index
        
    end
end

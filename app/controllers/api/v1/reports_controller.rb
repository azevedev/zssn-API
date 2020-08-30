class Api::V1::ReportsController < ApplicationController
    
    def create
        params.require(:id)
        @survivor = Survivor.find(params[:id])
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
        case params[:type]
            when '1'
                @total = Survivor.all.count
                @infecteds = Survivor.where(:infected => true)
                return render json: {"total_survivors" => @total, "total_infecteds" => @infecteds.count, "percentage" => (@infecteds.count.to_f/@total.to_f)*100, "infecteds" => @infecteds }
            when '2'
                @total = Survivor.all.count
                @non_infecteds = Survivor.where(:infected => false)
                return render json: {"total_survivors" => @total, "total_not_infecteds" => @non_infecteds.count, "percentage" => (@non_infecteds.count.to_f/@total.to_f)*100, "not-infecteds" => @non_infecteds }
            when '3'
                @survivor = Survivor.all
                @avg_water = 0.0
                @avg_food = 0.0
                @avg_med = 0.0
                @avg_ammo = 0.0
                @avg_coin = 0.0
                @survivor.each do |s|
                    @avg_water += s.inventory.items[0].amount #6
                    @avg_food += s.inventory.items[1].amount #12
                    @avg_med += s.inventory.items[2].amount #2 
                    @avg_ammo += s.inventory.items[3].amount #0
                    @avg_coin += s.inventory.items[4].amount #0
                end
                @avg_water /= @survivor.count
                @avg_food /= @survivor.count
                @avg_med /= @survivor.count
                @avg_ammo /= @survivor.count
                @avg_coin /= @survivor.count
                return render json: {"avg_water" => @avg_water, "avg_food" => @avg_food, "avg_medication" => @avg_med, "avg_ammunition" => @avg_ammo, "avg_coins" => @avg_coin }
            when '4'
                @infecteds = Survivor.where(:infected => true)
                @total = 0.0
                @infecteds.each do |s|
                    @total += s.inventory.items[0].value * s.inventory.items[0].amount
                    @total += s.inventory.items[1].value * s.inventory.items[1].amount
                    @total += s.inventory.items[2].value * s.inventory.items[2].amount
                    @total += s.inventory.items[3].value * s.inventory.items[3].amount
                    @total += s.inventory.items[4].value * s.inventory.items[4].amount
                end
                return render json: {"points_lost" => @total, "total_infected" => @infecteds.count}
            else
                return render json: {"error" => "The report :type is #{ params[:type].nil? ? "missing" : "invalid" }. Valid options are [1, 2, 3, 4]"}, status: :bad_request
        end 
    end
end

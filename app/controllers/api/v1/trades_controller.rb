class Api::V1::TradesController < ApplicationController
    def create 
        permitted = survivors_params
        @sur1 = Survivor.find(permitted[:survivor1_id])
        @sur2 = Survivor.find(permitted[:survivor2_id])
        if !@sur1.nil? and !@sur2.nil?
            return render json: {"error" => "Survivor #{@sur1.id} is infected! Trade canceled..."} if @sur1.infected 
            return render json: {"error" => "Survivor #{@sur2.id} is infected! Trade canceled..."} if @sur2.infected 
            @items_s1 = JSON.parse(params[:items_s1].to_s)
            @items_s2 = JSON.parse(params[:items_s2].to_s)
            sur1_items_hash = { 
                "water"      => @sur1.inventory.items[0].amount,
                "food"       => @sur1.inventory.items[1].amount,
                "medication" => @sur1.inventory.items[2].amount,
                "ammunition" => @sur1.inventory.items[3].amount,
                "coin"       => @sur1.inventory.items[4].amount
            }
            sur2_add = Hash.new(0)
            @items_s1.each do |i|
                if !sur1_items_hash[i.first].nil?
                    sur2_add[i.first] += i.last.to_i
                    if sur1_items_hash[i.first] >= i.last.to_i
                        sur1_items_hash[i.first] -= i.last.to_i
                    else 
                        puts "aisalksdjlkajsldkj"
                        puts sur1_items_hash[i.first]
                        puts i.last.to_i
                        puts "ops"
                        return render json: {"error" => "Survivor (#{@sur1.id}) doesn't have all items to trade" }, status: :bad_request  
                    end
                end
            end
           
            sur2_items_hash = { 
                "water"      => @sur2.inventory.items[0].amount,
                "food"       => @sur2.inventory.items[1].amount,
                "medication" => @sur2.inventory.items[2].amount,
                "ammunition" => @sur2.inventory.items[3].amount,
                "coin"       => @sur2.inventory.items[4].amount
            }
            sur1_add = Hash.new(0)
            @items_s2.each do |i|
                if !sur2_items_hash[i.first].nil?
                    sur1_add[i.first] += i.last.to_i
                    if sur2_items_hash[i.first] >= i.last.to_i
                        sur2_items_hash[i.first] -= i.last.to_i
                    else 

                        puts "aisudiuasd91826317263"
                        puts sur2_items_hash[i.first]
                        puts i.last.to_i
                        puts i.first
                        puts "ops"
                        return render json: {"error" => "Survivor (#{@sur2.id}) doesn't have all items to trade" }, status: :bad_request  
                    end
                end
            end
            result = evaluate(@items_s1, @items_s2)
            if(result == 0)
                puts "updating...."
                puts sur1_items_hash
                puts sur2_items_hash
                @sur1.inventory.items[0].update(:amount => sur1_items_hash["water"] + sur1_add["water"])
                @sur1.inventory.items[1].update(:amount => sur1_items_hash["food"] + sur1_add["food"])
                @sur1.inventory.items[2].update(:amount => sur1_items_hash["medication"] + sur1_add["medication"])
                @sur1.inventory.items[3].update(:amount => sur1_items_hash["ammunition"] + sur1_add["ammunition"])
                @sur1.inventory.items[4].update(:amount => sur1_items_hash["coin"] + sur1_add["coin"])
                
                @sur2.inventory.items[0].update(:amount => sur2_items_hash["water"] + sur2_add["water"])
                @sur2.inventory.items[1].update(:amount => sur2_items_hash["food"] + sur2_add["food"])
                @sur2.inventory.items[2].update(:amount => sur2_items_hash["medication"] + sur2_add["medication"])
                @sur2.inventory.items[3].update(:amount => sur2_items_hash["ammunition"] + sur2_add["ammunition"])
                @sur2.inventory.items[4].update(:amount => sur2_items_hash["coin"] + sur2_add["coin"])
                
                return head :no_content
            else  
                if(result > 0)
                    return render json: {"error" => "Survivor (#{@sur1.id}) has more valuable goods" }, status: :bad_request  
                end 
                if(result < 0)
                    return render json: {"error" => "Survivor (#{@sur2.id}) has more valuable goods" }, status: :bad_request  
                end
            end
            
        else
            render json: {"errors" => [ @sur1.errors, @sur2.errors] }, status: :unprocessable_entity  
        end 
    end

    def survivors_params
        params.require(:survivor1_id)
        params.require(:survivor2_id)
        params.permit(:survivor1_id, :survivor2_id)
    end

    def evaluate(arr1, arr2)
        value = 0
        arr1.each do |el|
            value += el[0] == "water"     ? 4 * el[1] : 0  
            value += el[0] == "food"       ? 3 * el[1] : 0  
            value += el[0] == "medication" ? 2 * el[1] : 0  
            value += el[0] == "ammunition" ? 1 * el[1] : 0  
        end
        puts value
        arr2.each do |el|
            value -= el[0] == "water"     ? 4 * el[1] : 0  
            value -= el[0] == "food"       ? 3 * el[1] : 0  
            value -= el[0] == "medication" ? 2 * el[1] : 0  
            value -= el[0] == "ammunition" ? 1 * el[1] : 0  
        end
        puts value
        value
    end

end

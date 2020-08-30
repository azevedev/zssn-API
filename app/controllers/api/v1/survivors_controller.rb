class Api::V1::SurvivorsController < ApplicationController
   
    # GET /api/survivors --> Get all the survivors, non-infected included;
    def index
        puts "getting all survivors"
        @survivors = Survivor.all

        render json: {"total" => @survivors.count, "survivors" => @survivors}
        # render json: @survivors
    end

    # GET /api/survivor --> Get one single survivor, given it's ID;
    def show 
        puts "get one single survivor"
        params.require(:id)
        @survivor = Survivor.find(params.permit(:id)[:id])
        render json: {survivor: @survivor, last_location: @survivor.location, inventory: [ @survivor.inventory, items: @survivor.inventory.items ] }
    end
    
    # POST /api/survivor --> Adds a new survivor to the database;
    def create
        @survivor = Survivor.new(survivor_params)
        @survivor.location = Location.new(location_params) 
        @survivor.inventory = Inventory.new() 
        @survivor.inventory.items.push(Item.new(:name=> "water", :value => 4, :weight => 2))
        @survivor.inventory.items.push(Item.new(:name => "food", :value => 3 , :weight => 3))
        @survivor.inventory.items.push(Item.new(:name => "medication", :value => 2 , :weight => 1))
        @survivor.inventory.items.push(Item.new(:name => "ammunition", :value => 1 , :weight => 4))
        @survivor.inventory.items.push(Item.new(:name => "coin", :value => 1 , :weight => 0))
        # @survivor.inventory.save
        @items = JSON.parse(params.require(:items))
        keys = {"water" => 0, "food" => 1, "medication" => 2, "ammunition" => 3, "coin" => 4}
        keys.default = 5
        puts keys["water"]
        puts keys["asd"]
        @capacity = 0
        @items.each do |item|
            @item = @survivor.inventory.items[keys[item.first]]
            puts "item"
            puts @item
            if !@item.nil?
                @item.amount += item.last
                @capacity += @item.weight * item.last
            end
        end
       @survivor.inventory.capacity = params[:capacity].nil? ? @capacity * 2 : params[:capacity]
       if @survivor.save
          head :no_content
       else
          render json: @survivor.errors, status: :unprocessable_entity
       end
    end
   
    # PUT /api/survivor --> Updates the location of one survivor;
    def update_location
        @survivor = params.require(:survivor_id).permit(:survivor_id)
        if !@survivor.nil?
            puts "updating survivor location"
            @survivor.location = Location.new(location_params)
            if @survivor.save
                head :no_content
            else
                render json: @survivor.errors, status: :unprocessable_entity
            end
        else
            render json: @survivor.errors, status: :unprocessable_entity
        end
    end

    def survivor_params
        params.require(:name)
        params.require(:age)
        params.require(:gender)
        params.permit(:name,:age,:gender)
    end

    def location_params
        params.require(:latitude)
        params.require(:longitude)
        params.permit(:latitude, :longitude)
    end

end
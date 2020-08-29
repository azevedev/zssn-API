class Api::V1::SurvivorsController < ApplicationController
    # POST /api/survivor --> Adds a new survivor to the database;
    
    def add_survivor
        @survivor = Survivor.new(survivor_params)
        @survivor.location = Location.new(location_params) 
        @survivor.inventory = Inventory.new(inventory_params) 
        @survivor.save!
        @survivor.inventory.items.create(:name=> "water", :value => 4, :weight => 2)
        @survivor.inventory.items.create(:name => "food", :value => 3 , :weight => 3)
        @survivor.inventory.items.create(:name => "medication", :value => 2 , :weight => 1)
        @survivor.inventory.items.create(:name => "ammunition", :value => 1 , :weight => 4)
        @survivor.inventory.save!
        
        @items = JSON.parse(params.require(:items))
        @capacity = 0
       
        @items.each do |item|
            @item = @survivor.inventory.items.find_by(name: item[0])
            puts "what item is this?"
            puts @item
            @item.amount += item[1]
            @capacity += @item.weight * item[1]
            @item.save!
        end
       @survivor.inventory.capacity = @capacity * 2
       @survivor.inventory.save!
    end

    # GET /api/survivor --> Get one single survivor, given it's ID;
    def get_survivor 
        puts "get one single survivor"
        @survivor = Survivor.find(params.require(:survivor_id).permit(:survivor_id))
        render json: {survivor: @survivor, inventory: [ @survivor.inventory, items: @survivor.inventory.items ] }
    end
    # GET /api/survivors --> Get all the survivors, non-infected included;
    def get_all_survivors
        puts "getting all survivors"
        @survivors = Survivor.all

        # render json: {"total" => @survivors.count, "survivors" => @survivors}
        render json: @survivors
    end
    # PUT /api/survivor --> Updates the location of one survivor;
    def update_location
        @survivor = params.require(:survivor_id).permit(:survivor_id)
        if !@survivor.nil?
            puts "updating survivor location"
            @survivor.location = Location.new(location_params)
            if @survivor.save
                render json: @survivor, status: :success
            else
                render json: @survivor.errors, status: :unprocessable_entity
            end
        else
    end

    def survivor_params
        params.require(:name)
        params.require(:age)
        params.require(:gender)
        params.permit(:name,:age,:gender)
    end
    
    def inventory_params
        params.require(:capacity)
        params.permit(:capacity)
    end

    def location_params
        params.require(:latitude)
        params.require(:longitude)
        params.permit(:latitude, :longitude)
    end

end
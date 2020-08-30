class Api::V1::SurvivorsController < ApplicationController
   
    # GET /api/v1/survivors --> Get all the survivors, non-infected included;
    def index
        puts "getting all survivors"
        survivors = Survivor.all
        puts survivors
        puts "dude"
        puts params
        render json: {"total" => 7, "survivors" => survivors.select(:id, :name, :age, :gender, :reports, :infected) } , status: :ok
        # render json: @survivors
    end

    # GET /api/v1/survivor --> Get one single survivor, given it's ID;
    def show 
        puts "get one single survivor"
        params.require(:id)
        survivor = Survivor.select(:id, :name, :age, :gender, :reports, :infected).where(id: params.permit(:id)[:id]).first
        location = Location.select(:id, :latitude, :longitude).where(id: survivor.id).first
        inventory = Inventory.select(:id, :capacity).where(survivor_id: survivor.id).first
        items = Item.select(:id, :name, :value, :weight, :amount).where(inventory_id: inventory.id)
        inv_it = { "id" => inventory.id, "capacity" => inventory.capacity, "items" => items }
        render json: {survivor: survivor, last_location: location, inventory: inv_it }, status: :ok 
    end
    
    # POST /api/v1/survivor --> Adds a new survivor to the database;
    def create
        require 'json'
        survivor = Survivor.new(survivor_params)
        survivor.location = Location.new(location_params) 
        survivor.inventory = Inventory.new() 
        survivor.inventory.items.push(Item.new(:name=> "water", :value => 4, :weight => 2))
        survivor.inventory.items.push(Item.new(:name => "food", :value => 3 , :weight => 3))
        survivor.inventory.items.push(Item.new(:name => "medication", :value => 2 , :weight => 1))
        survivor.inventory.items.push(Item.new(:name => "ammunition", :value => 1 , :weight => 4))
        survivor.inventory.items.push(Item.new(:name => "coin", :value => 1 , :weight => 0))
        # survivor.inventory.save
        p_items = params.require(:items).to_s
        puts params
        puts "getting items..."
        puts p_items
        if p_items.size > 0
            puts "not empty"
        else 
            puts "empty"
        end
        items = JSON.parse(p_items)
        keys = {"water" => 0, "food" => 1, "medication" => 2, "ammunition" => 3, "coin" => 4}
        keys.default = 5
        puts keys["water"]
        puts keys["asd"]
        capacity = 0
        items.each do |item|
            sur_good = survivor.inventory.items[keys[item.first]]
            puts "item"
            puts item
            if !sur_good.nil?
                sur_good.amount += item.last
                capacity += sur_good.weight * item.last
            end
        end
       survivor.inventory.capacity = params[:capacity].nil? ? capacity * 2 : params[:capacity]
       if survivor.save
          render json: survivor, status: :created
       else
          render json: survivor.errors, status: :unprocessable_entity
       end
    end
    
    # PUT /api/v1/survivor/:id/location --> Updates the location of one survivor;
    def update_location
        params.require(:id)
        id = params[:id]
        survivor = Survivor.find(id)
        if !survivor.nil?
            location_params
            survivor.location.update({:latitude => params[:latitude], :longitude => params[:longitude]})
            if survivor.save
                head :no_content
            else
                render json: survivor.errors, status: :unprocessable_entity
            end
        else
            render json: survivor.errors, status: :unprocessable_entity
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
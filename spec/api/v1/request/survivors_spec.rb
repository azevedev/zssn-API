require 'rails_helper'

RSpec.describe "Survivors requests", type: :request do 
    describe 'API Version 1.0 -> GET /survivors' do 
        it 'returns a array of survivors' do
            get api_v1_survivors_path
            res = JSON.parse(response.body)
            expect(res).to include(
                { 
                    "total" => 7, 
                    "survivors" => [
                        {"name" => "", "age"=>21, "gender"=>"Male", "id"=>1, "infected"=>false, "name"=>"Jorge", "reports"=>0}, 
                        {"age"=>32, "gender"=>"Female", "id"=>2, "infected"=>false, "name"=>"Marge", "reports"=>0}, 
                        {"age"=>19, "gender"=>"Male", "id"=>3, "infected"=>false, "name"=>"Phill", "reports"=>2}, 
                        {"age"=>24, "gender"=>"Female", "id"=>4, "infected"=>false, "name"=>"Pamn", "reports"=>1}, 
                        {"age"=>67, "gender"=>"Male", "id"=>5, "infected"=>false, "name"=>"John", "reports"=>0}, 
                        {"age"=>31, "gender"=>"Male", "id"=>6, "infected"=>true, "name"=>"Matthew", "reports"=>6}, 
                        {"age"=>42, "gender"=>"Female", "id"=>7, "infected"=>true, "name"=>"Kayle", "reports"=>4}
                    ]
                }
            ) 
            expect(response).to have_http_status(200)
        end
    end
    describe 'API Version 1.0 -> GET /survivors/:id' do 
        it 'returns a array with data of one single survivor' do
            get api_v1_survivor_path(1)
            res = JSON.parse(response.body)
            expect(res).to include(
                {
                    "survivor" => {
                        "id" => 1,
                        "name" => "Jorge",
                        "age" => 21,
                        "gender" => "Male",
                        "reports" => 0,
                        "infected" => false
                    },
                    "inventory" => {
                        "id"=>1,
                        "capacity"=>148, 
                        "items"=>[
                            {"amount"=>3, "id"=>1, "name"=>"water", "value"=>4, "weight"=>2.0}, 
                            {"amount"=>4, "id"=>2, "name"=>"food", "value"=>3, "weight"=>3.0}, 
                            {"amount"=>8, "id"=>3, "name"=>"medication", "value"=>2, "weight"=>1.0}, 
                            {"amount"=>12, "id"=>4, "name"=>"ammunition", "value"=>1, "weight"=>4.0}, 
                            {"amount"=>234, "id"=>5, "name"=>"coin", "value"=>1, "weight"=>0.0}
                        ]
                    },
                    "last_location" => {"id"=>1, "latitude"=>"318273.0", "longitude"=>"6532.0"},
                    "survivor" => {"age"=>21, "gender"=>"Male", "id"=>1, "infected"=>false, "name"=>"Jorge", "reports"=>0},
                }
            )
            expect(response).to have_http_status(200) 
        end
    end

    describe 'API Version 1.0 -> POST /survivors' do 
        it 'sends a request to create a new survivor' do
            post api_v1_survivors_path, params: {name: "My Name", age: 25, gender: "Male", latitude: 123, longitude: 123, items: [["asd", 3]]}
            res = JSON.parse(response.body)
            expect(res).to include(

            )
            expect(response).to have_http_status(201)
        end
    end
    
    describe 'API Version 1.0 -> PUT /survivor/:id/location' do 
        it 'sends a request to update a survivor location' do
            put api_v1_location_path(1), params: { longitude: 4123, latitude: 45413 } 
            expect(response).to have_http_status(204)
        end
    end
end
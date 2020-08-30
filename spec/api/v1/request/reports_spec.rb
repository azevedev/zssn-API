require 'rails_helper'

RSpec.describe "Reports requests", type: :request do 
    describe 'API Version 1.0 -> GET /reports' do 
        it 'returns a array with the specific report of survivors' do
            get api_v1_reports_path, params: {type: 1}
            res = JSON.parse(response.body)
            expect(res).to include(
                { 
                    "total_survivors" => 7, 
                    "total_infecteds" => 2,
                    "percentage" => 28.57142857142857,
                    "infecteds" => [
                        {"name" => "Matthew", "age"=>31, "gender"=>"Male", "id"=>6, "infected"=>true, "name"=>"Matthew", "reports"=>6}, 
                        {"name" => "Kayle", "age"=>42, "gender"=>"Female", "id"=>7, "infected"=>true, "name"=>"Kayle", "reports"=>4}
                    ]
                }
            ) 
            expect(response).to have_http_status(200)
        end
    end

    describe 'API Version 1.0 -> POST /reports' do 
        it 'create a report of a single survivor (flagged as infected after 3 reports)' do
            post api_v1_reports_path, params: {id: 1}
            expect(response).to have_http_status(204)
        end
    end
end



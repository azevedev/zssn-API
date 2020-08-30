require 'rails_helper'

RSpec.describe "Trades requests", type: :request do 
    describe 'API Version 1.0 -> POST /trades' do 
        it 'creates a new trade with two survivors' do
            post api_v1_trades_path, params: {survivor1_id: 1, survivor2_id: 2, items_s1: [["water", 1]], items_s2: [["medication", 1]]}
            expect(response).to have_http_status(204)
        end
    end
end
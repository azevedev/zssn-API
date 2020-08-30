require 'rails_helper'

RSpec.describe "Survivors requests" do 
    context 'API Version 1.0 -> GET /survivors' do 
        it 'returns a array of survivors' do
            get('/api/v1/survivors')
            res = JSON.parse(response.body)
            expect(res['status']).to include()
            expect(response.status).to eql(200)
        end
    end
end
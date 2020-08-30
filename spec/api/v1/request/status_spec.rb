require 'rails_helper'

RSpec.describe "Status API" do 
    context 'API Version 1.0 -> GET /status' do 
        it 'returns a status message' do
            get('/api/v1/status')
            res = JSON.parse(response.body)
            expect(res['status']).to eql('ok')
        end
    end
end
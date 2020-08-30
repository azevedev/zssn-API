class Api::V1::StatusController < ApplicationController
    def status
        render json: {"status" => "ok"}
    end
end
class Settings::CreatorController < ApplicationController
    def show
        @creator = Current.user.creators.find_by(uuid: params[:uuid])
    end

    def update
    end

    private
        def creator_params
            params.expect(creator: [:name, :description])
        end
end
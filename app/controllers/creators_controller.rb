class CreatorsController < ApplicationController

    def index
        @creators = Current.user.creators
    end

    def new
        @creator = Creator.new
    end

    def create
        @creator = Current.user.creators.create(creator_params)
        if @creator
            redirect_to settings_profile_page_path, status: :see_other
        else 
           render :new, status: :unprocessable_entity
        end
    end

    private
    def creator_params
        params.expect(creator: [:name, :description])
    end
end

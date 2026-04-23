class CreatorsController < ApplicationController

    def show
        @creator = Creator.includes(:writings).find_by(uuid: params[:uuid])
        puts @creator
    end

    def edit
        @creator = Current.user.creators.find_by(uuid: params[:uuid])
        
    end

    def update
     @creator = Current.user.creators.find(params[:id])
     if @creator.update(creator_params)
        redirect_to "/settings/creator/#{@creator.uuid}", status: :see_other
     else
        render :edit, status: :unprocessable_entity
     end
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

    def destroy
        @creator = Current.user.creators.find(params[:id])
        if @creator.destroy
            redirect_to "/settings/profile_page", status: :see_other
        else
            render :edit, status: :unprocessable_entity
        end

    end

    private
    def creator_params
        params.expect(creator: [:name, :description, :about])
    end
end

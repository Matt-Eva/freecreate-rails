class WritingsController < ApplicationController
    def new
        @writing = Writing.new()
        @creators = Current.user.creators
    end

    def create
        @user = Current.user
        @creator = Creator.find_by(uuid: params[:creator_uuid])
        new_writing_params = {
            user_id: @user.id,
            creator_id: @creator.id,
            title: params[:title],
            description: params[:description]
        }
        
        else
            render :new, status: :unprocessable_entity
        end
    end

    private     
        def writing_params
            params.permit(writing: [:title, :tags, :genres, :description])
        end
end

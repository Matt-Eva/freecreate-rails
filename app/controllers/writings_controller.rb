class WritingsController < ApplicationController
    def new
        @writing = Writing.new()
        @creators = Current.user.creators
    end

    def create
        @user = Current.user
        @creator = @user.creators.find_by(uuid: params[:creator_uuid])
        new_writing_params = {
            user_id: @user.id,
            creator_id: @creator.id,
            title: params[:title],
            description: params[:description],
            last_published: Time.now
        }
        @writing = Writing.create(new_writing_params)
        if @writing
            redirect_to "/writings/#{@writing.uuid}/edit", status: :see_other
        else    
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @user = Current.user
        @writing = @user.writings.find_by(uuid: params[:uuid]).includes(:creator)
        @creators = @user.creators
    end

    # private     
    #     def writing_params
    #         params.permit(writing: [:title, :tags, :genres, :description])
    #     end
end

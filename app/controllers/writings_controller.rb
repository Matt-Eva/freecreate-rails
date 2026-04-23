class WritingsController < ApplicationController
    def new
        @writing = Writing.new()
        @creators = Current.user.creators
    end

    def create
        @user = Current.user
        puts(params)
        @creator = @user.creators.find_by(uuid: params[:writing][:creator_uuid])
        puts(@creator.id)
        new_writing_params = {
            user_id: @user.id,
            creator_id: @creator.id,
            title: params[:writing][:title],
            last_published: Time.now
        }
        puts(new_writing_params)
        @writing = Writing.create(new_writing_params)
        if @writing
            redirect_to "/writings/#{@writing.uuid}/edit", status: :see_other
        else    
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @user = Current.user
        @writing = @user.writings.includes(:creator).find_by(uuid: params[:uuid])
        @creators = @user.creators
    end

    # private     
    #     def writing_params
    #         params.permit(writing: [:title, :tags, :genres, :description])
    #     end
end

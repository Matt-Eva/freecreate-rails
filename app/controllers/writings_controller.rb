class WritingsController < ApplicationController

    def index
        @writings = Current.user.writings.order(:last_published)
        @published_writing =[]
        @unpublished_writing = []
        @writings.each do |writing|
            if writing.published
                @published_writing.push(writing)
            else
                @unpublished_writing.push(writing)
            end
        end
    end

    def new
        @writing = Writing.new()
        @creators = Current.user.creators
    end

    def create
        @user = Current.user
        if @user
            @creator = @user.creators.find_by(uuid: params[:writing][:creator_uuid])
            if @creator
                new_writing_params = {
                    user_id: @user.id,
                    creator_id: @creator.id,
                    writing_type: params[:writing][:writing_type],
                    title: params[:writing][:title],
                    last_published: Time.now
                }
                @writing = Writing.create(new_writing_params)
                if @writing
                    redirect_to "/writings/#{@writing.uuid}/edit", status: :see_other
                else    
                    render :new, status: :unprocessable_entity
                end
            end
        end
    end

    def edit
        @user = Current.user
        @writing = @user.writings.includes(:creator).find_by(uuid: params[:uuid])
        @creators = @user.creators
    end

    def update
    end

    # private     
    #     def writing_params
    #         params.permit(writing: [:title, :tags, :genres, :description])
    #     end
end

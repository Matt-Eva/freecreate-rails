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

        puts @writing.writing_type
        @creators = @user.creators
    end

    def update
        writing_params = params[:writing]
        @user = Current.user
        @writing = @user.writings.find_by(uuid: params[:uuid])
        @creators = @user.creators
        creator = @creators.find {|c| c.uuid == writing_params[:creator_uuid]}
        puts writing_params
        if creator
            update_hash = {
                creator_id: creator.id,
                topics: (writing_params[:topics] ? writing_params[:topics] : ["No Topic"]),
                title: writing_params[:title],
                tags: (writing_params[:tags] ? writing_params[:tags] : []),
                writing_type: writing_params[:writing_type],
                description: writing_params[:description],
            }
            puts update_hash
            if @writing.update(update_hash)
                puts @writing
                respond_to do |format|

                    format.html { render :edit, status: :accepted }
                end
            else
                puts "unprocessable entity"
                render :edit, status: :unprocessable_entity
            end
        else
            puts "creator not found"
            render :edit, status: :not_found
        end
    end

    def publish
        @writing = Current.user.writings.find_by(uuid: params[:uuid])
        if @writing
            update_hash = {
                published: !@writing.published
            }
            if @writing.never_published
                update_hash[:never_published] = false
                update_hash[:last_published] = Time.now
            end

            if @writing.update(update_hash)
                respond_to do |format|
                    format.turbo_stream do 
                        render turbo_stream: turbo_stream.replace(
                            "publish_writing_button", 
                            partial: "publish_writing_button",
                            writing: @writing
                        )  
                    end
                    format.html {render :edit, status: :accepted}
                end
            else
                render :edit, status: :unprocessable_entity
            end
        else
            render :edit, status: :not_found
        end
    end

  # private
  #     def writing_params
  #         params.permit(writing: [:title, :tags, :genres, :description])
  #     end
end

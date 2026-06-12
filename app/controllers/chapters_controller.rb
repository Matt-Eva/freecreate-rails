class ChaptersController < ApplicationController
    def create
        # puts params
        writing_uuid = params[:writing_uuid]
        chapter_params = params[:chapter]
        @user = Current.user
        @writing = @user.writings.find_by(uuid: writing_uuid)
        if @writing
            create_chapter_params = {
                title: chapter_params[:title],
                number: chapter_params[:number],
                originally_published: Time.now,
                writing_id: @writing.id,
                user_id: @user.id
            }
            if nil # Chapter.create!(create_chapter_params)
            else
                @chapter = Chapter.new
                @creators = @user.creators
                render template: "writings/edit", status: :unprocessable_entity
            end
        else
            redirect_to ('/writings')
        end
    end
end

class Settings::ProfilePageController < ApplicationController
    def index
    end

    def update_username
        puts params
        if Current.user.update(username: params[:username])
            render :index, status: :see_other, notice: "Your profile was successfully updated"
        else
            render :index, status: :unprocessable_entity
        end
    end
end

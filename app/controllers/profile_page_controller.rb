class ProfilePageController < ApplicationController
    def index
        puts Current.user.username
    end

    def update_username
        puts params
        if Current.user.update(username: params[:username])
            render :index, status: :see_other, notice: "Your profile was successfully updated"
        else

        end
    end
end

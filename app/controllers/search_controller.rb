class SearchController < ApplicationController
    allow_unauthenticated_access
    def index
        puts params
        @title = ""
        if params[:title].present?
            @title = params[:title]
        end
        
    end
end
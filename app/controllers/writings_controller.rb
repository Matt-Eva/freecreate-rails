class WritingsController < ApplicationController
    def new
        @writing = Writing.new()
    end
end

require 'streamio-ffmpeg'

class RiffsController < ApplicationController
    # not needed because disabled for whole app?
    #skip_before_action :verify_authenticity_token

    def show
        @riff = Riff.find(params[:id])
        send_data @riff.audio_datum
    end
    def create
        movie = FFMPEG::Movie.new(params[:blob].tempfile.path)

        movie.transcode("/tmp/movie.mp4") 

        debugger

        mp4data = File.read("/tmp/movie.mp4")
        
        @riff = Riff.new(audio_datum: mp4data, isText: false, user_id: 1, video_id: 1)

        @riff.save
    end
end

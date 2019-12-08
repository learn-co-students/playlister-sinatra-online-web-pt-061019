require 'rack-flash'

class SongsController < ApplicationController
  enable :sessions
  use Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do
    @songs = Song.all
    @genres = Genre.all
    erb :'/songs/new'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @songs = Song.all
    @artists = Artist.all
    @genres = Genre.all
    erb :'songs/show'
  end

  post '/songs' do
    @song = Song.create(params[:song])
    @song.genre_ids = params[:genre]
    if !params["artist"]["name"].empty?
      @song.artist = Artist.find_or_create_by(params[:artist])
      @song.artist.save
    end
    @song.save
    flash[:message] = "Successfully created song."
    redirect to "/songs/#{@song.slug}"
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    @genres = Genre.all
    erb :'songs/edit'
  end

  patch '/songs/:slug' do
    #binding.pry
    @song = Song.find_by_slug(params[:slug])
    @song.genre_ids = params[:genre]
    if !params["artist"]["name"].empty?
      @song.artist = Artist.find_or_create_by(params[:artist])
    end
    @song.save
    flash[:message] = "Successfully updated song."
    redirect to "/songs/#{@song.slug}"
  end

end

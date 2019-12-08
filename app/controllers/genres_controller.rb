class GenresController < ApplicationController

  get '/genres' do
    @genres = Genre.all
    erb :'/genres/index'
  end

  get '/genres/:slug' do
    @artists = Artist.all
    @songs = Song.all
    @genres = Genre.all
    erb :'/genres/show'
  end

end

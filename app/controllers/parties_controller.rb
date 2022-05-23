class PartiesController < ApplicationController

  def new
    @movie = MovieFacade.find_movie(params[:movie_id])
    @user = User.find(params[:user_id])
    @users = User.all
  end

  def create
    @movie = MovieFacade.find_movie(params[:movie_id])
    new_party = Party.new(party_params)

    if @movie.runtime <= params[:duration].to_i
      if new_party.save && params[:users]
        params[:users].each do |user|
          PartyUser.create(user_id: User.find(user), party: new_party, host: false)
        end
        PartyUser.create(user_id: params[:host], party: new_party, host: true)
        redirect_to "/users/#{new_party.host}"
      else
        render :new
      end
    else
      redirect_to "/users/#{params[:host]}/movies/#{@movie.id}/viewing_party/new"
      require "pry"; binding.pry
      flash[:notice] = {message: "Duration must be longer than movie"}
    end
  end

private

    def party_params
      params.permit(:id, :duration, :date, :time, :host, :movie_id)
    end
end

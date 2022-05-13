require 'rails_helper'

RSpec.describe Movie do
  it 'exists' do
    movie_data = {
      title: "Fun Movie",
      id: 4,
      overview: "Lots of laughs for half your family",
      vote_average: 7.2,
      runtime: 102,
      credits: {
        cast: [
          {name: "Matthew Lewis",
           character: "Neville Longbottom"},
          {name: "Emilia Clark",
           character: "Khaleesi"},
          {name: "Orlando Bloom",
           character: "Legolas"},
          {name: "Johnny Depp",
           character: "Captain Jack Sparrow"},
          {name: "Leonardo DiCaprio",
           character: "Jack Dawson"},
          {name: "Robin Williams",
           character: "The Genie"},
          {name: "Matt Damon",
           character: "Jason Bourne"},
          {name: "Mike Meyers",
           character: "Austin Powers"},
          {name: "Jennifer Lawrence",
           character: "Katniss Everdeen"},
          {name: "Brad Pitt",
           character: "Tyler Durden"}
        ]
      },
      reviews: {
        results: [
          {author: "Samwise Gamgee",
           content: "This movie is WILD"},
          {author: "Draco Malfoy",
           content: "It would have been better if my father produced it"}
        ]
      },
      genres: [
        {id: 2,
         name: "Comedy"},
        {id: 5,
         name: "Science Fiction"},
        {id: 1,
         name: "Drama"}
      ]
    }
    movie = Movie.new(movie_data)
    expect(movie).to be_a Movie
    expect(movie.title).to eq(movie_data[:title])
    expect(movie.vote_average).to eq(movie_data[:vote_average])
    expect(movie.id).to eq(movie_data[:id])
    expect(movie.cast).to eq(movie_data[:credits][:cast][0..9])
    expect(movie.runtime).to eq(movie_data[:runtime])
    expect(movie.genres).to eq(movie_data[:genres].map {|g| g[:name]})
    expect(movie.summary).to eq(movie_data[:overview])
    expect(movie.reviews).to eq(movie_data[:reviews][:results])
  end
end

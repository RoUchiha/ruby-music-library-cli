require 'pry'

class MusicLibraryController

    attr_accessor :path
    
    def initialize(path = './db/mp3s')
        path = path
        MusicImporter.new(path).import
    end

    def call
        user_input = ""
        while user_input != "exit"
            puts "Welcome to your music library!"
            puts "To list all of your songs, enter 'list songs'."
            puts "To list all of the artists in your library, enter 'list artists'."
            puts "To list all of the songs by a particular artist, enter 'list artist'."
            puts "To list all of the genres in your library, enter 'list genres'."
            puts "To list all of the songs of a particular genre, enter 'list genre'."
            puts "To play a song, enter 'play song'."
            puts "To quit, type 'exit'."
            puts "What would you like to do?"
                
            user_input = gets.strip
            case user_input
            
            when "list songs"
                list_songs
            when "list artists"
                list_artists
            when "list artist"
                list_songs_by_artist
            when "list genres"
                list_genres
            when "list genre"
                list_songs_by_genre
            when "play song"
                play_song
            end
        end
    end

    def list_songs
        order = Song.all.sort_by { |s| s.name }
        order.each.with_index(1) do |s, i|
        puts "#{i}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
        end
    end

    def list_artists
        order = Artist.all.sort_by {|a| a.name }
        order.each.with_index(1) do |a, i|
            puts "#{i}. #{a.name}"
        end
    end

    def list_genres 
        order = Genre.all.sort_by { |g| g.name }
        order.each.with_index(1) do |g, i|
            puts "#{i}. #{g.name}"
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        a_input = gets.strip
        Artist.all.each do |a|
            if a.name == a_input
                order = a.songs.sort_by {|s| s.name }
                order.each.with_index(1) do |s, i|
                    puts "#{i}. #{s.name} - #{s.genre.name}"
                end
            end
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        g_input = gets.strip
        Genre.all.each do |g|
            if g.name == g_input
                order = g.songs.sort_by {|s| s.name }
                order.each.with_index(1) do |s, i|
                    puts "#{i}. #{s.artist.name} - #{s.name}"
                end
            end
        end
    end

    def play_song
       puts "Which song number would you like to play?"
       play_input = gets.strip
       order = Song.all.sort_by{ |s| s.name }
       puts "Playing #{order[play_input.to_i-1].name} by #{order[play_input.to_i-1].artist.name}" unless play_input.to_i < 1 || play_input.to_i > Song.all.length
    end


end
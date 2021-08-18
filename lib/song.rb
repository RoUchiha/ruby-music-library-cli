class Song

    attr_accessor :name, :artist, :genre
    attr_reader 

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.songs << self unless genre.songs.include?(self)
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def save 
        self.class.all << self
        self
    end

    def self.create(name, artist = nil, genre = nil)
        new(name, artist, genre).tap{|s| s.save}
        
    end

    def self.find_by_name(name)
        self.all.detect { |s| s.name == name }
    end

    def self.find_or_create_by_name(name)
        if find_by_name(name) != nil
            return find_by_name(name)
        else
            self.create(name)
        end
    end

    def self.new_from_filename(file)
        pieces = file.split(" - ")
        artist = Artist.find_or_create_by_name(pieces[0])
        genre = Genre.find_or_create_by_name(pieces[2].gsub(".mp3", ""))
        self.new(pieces[1], artist, genre)
    end

    def self.create_from_filename(file)
        self.new_from_filename(file).save
    end


end
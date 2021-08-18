class MusicImporter

    attr_accessor :path

    def initialize(path)
        @path = path
    end

    def files
        @files = Dir.chdir(@path) do |path|
            Dir.glob("*.mp3")
        end
    end

    def import
        files.each do |f|
            Song.create_from_filename(f)
        end
    end






end
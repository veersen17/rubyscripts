class Song
    def initialize (name,artist,duration)
        @name     = name
        @artist   = artist
        @duration = duration
    end
    def to_s
      p  "Song:#{@name} -- #{@artist} -- #{@duration} "
    end
end


class KaraokeSong < Song
  def initialize(name, artist, duration, lyrics)
    super(name, artist, duration)
    @lyrics = lyrics
  end
end
a.to_s


Song = KaraokeSong.new("My Way", "Sinatra", 225, "And now, the...")
aSong
class TmdbGenre
  def self.all(options = nil)
    
    results = []
    results << Tmdb.api_call("Genres.getList")
    results.flatten!
    results.compact!
    
    unless(options.nil? || options[:limit].nil?)
      raise ArgumentError, ":limit must be an integer greater than 0" unless(options[:limit].is_a?(Fixnum) && options[:limit] > 0)
      results = results.slice(0, options[:limit])
    end
    
    results.map!{|m| TmdbGenre.new(m) }
    
    if(results.length == 1)
      return results[0]
    else
      return results
    end
  end
  
  def self.limit(limit)
    raise ArgumentError, "The limit must be an integer greater than 0" unless(limit.is_a?(Fixnum) && limit > 0)
    TmdbGenre.all(:limit => limit)
  end
  
  def self.new(raw_data, expand_results = false)
    return Tmdb.data_to_object(raw_data)
  end
  
  def ==(other)
    return false unless(other.is_a?(TmdbMovie))
    return @raw_data == other.raw_data
  end
end
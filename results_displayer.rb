class ResultsDisplayer
  def initialize frequencies
    @frequencies = frequencies
  end

  def display
    normalized_frequencies.each do |frequencies|
      puts "\nAverage atomic mass: #{frequencies[0]}"
      puts "  mass    frequency (%)"
      frequencies[1].each do |mass, frequency|
        mass = mass.to_s.rjust(2, " ")
        puts "  #{mass}       #{frequency}"
      end
    end
  end

  def frequencies
    @frequencies ||= {}
  end

  def normalized_frequencies
    sorted_frequencies.each do |mean_mass, counts|
      total = counts.inject(0){|sum, count| sum + count[1].to_i}

      frequencies[mean_mass].each do |mass, val|
        frequencies[mean_mass][mass] = (100.0 * val/total).round
      end
    end
  end

  def sorted_frequencies
    # Sort qualified frequencies
    frequencies.each do |k, v|
      frequencies[k] = sort_by_atomic_mass v
    end

    # Sort conditional frequencies
    sort_by_atomic_mass frequencies
  end

  def sort_by_atomic_mass h
    h = Hash[h.sort_by{|k,v| k.to_i}]
  end
end

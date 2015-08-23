#!/usr/local/ruby
class AnalysisMethod
  def initialize
  end

  def frequencies_given_metric metric
    frequencies[metric] ||= {}
  end

  def frequencies
    @frequencies ||= {}
  end

end

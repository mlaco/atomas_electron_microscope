#!/usr/local/ruby
require 'json'

class Spectrograph
  def operate data_file, analysis_method
    @analysis_method = analysis_method
    f = File.open(data_file)
    while line = f.gets do
      @sample = JSON.parse line
      analyze_sample
    end
    @analysis_method.normalized_frequencies.each do |frequencies|
      puts "\nAverage atomic mass: #{frequencies[0]}"
      puts "  mass    frequency (%)"
      frequencies[1].each do |mass, frequency|
        puts "  #{mass}       #{frequency}"
      end
    end
  end

  def atom_counts
    @atom_counts ||= {}
  end

  def analyze_sample

    # puts "processing next sample"
    @sample.each do |molecule|
      initial_atoms = molecule[0]
      added_atoms = molecule[1]

      # initialize atom counts
      initial_atoms.each do |atom|
        next unless atom.match /\d+/ # Filter out special atoms
        atom_count = atom_counts[atom] || 0
        atom_counts[atom] = atom_count + 1
      end

      x = atom_counts
      atom_counts = Hash[@atom_counts.sort_by{|k,v| k.to_i}]

      # process added atoms
      added_atoms.each do |atom|
        next unless atom.match /\d+/ # Filter out special atoms

        # factor this new atom into probabilities
        @analysis_method.analyze(atom_counts, atom)

        # add atom to atom counts
        atom_count = atom_counts[atom] || 0
        atom_counts[atom] = atom_count + 1

        atom_counts = Hash[atom_counts.sort_by{|k,v| k.to_i}]
      end
    end
  end
end

class AnalysisMethod
  def initialize
  end

  def frequencies_given_metric metrics
    frequencies[measure(metrics)] ||= {}
  end

  def frequencies
    @frequencies ||= {}
  end

  def sorted_frequencies
    frequencies.each do |k, v|
      frequencies[k] = sort_by_atomic_mass v
    end
    sort_by_atomic_mass frequencies
  end

  def sort_by_atomic_mass h
    h = Hash[h.sort_by{|k,v| k.to_i}]
  end

  def normalized_frequencies
    frequencies = sorted_frequencies
    frequencies.each do |mean_mass, counts|
      # puts "mean mass: #{mean_mass}, counts: #{counts}"
      total = counts.inject(0){|sum, count| sum + count[1].to_i}
      frequencies[mean_mass].each do |mass, val|
        frequencies[mean_mass][mass] = (100.0 * val/total).round
      end
    end
  end

  class MeanAnalysis < AnalysisMethod
    def analyze atom_counts, atom
      atom_frequencies = frequencies_given_metric(atom_counts)
      atom_frequency = atom_frequencies[atom] || 0
      atom_frequencies[atom] = atom_frequency + 1
    end

    def measure atom_counts
      if atom_counts.length > 0
        total_mass = atom_counts.inject(0){|mass, atom_count| mass.to_i + atom_count[0].to_i * atom_count[1].to_i}
        number_atoms = atom_counts.inject(0){|count, atom_count| count + atom_count[1].to_i }
        mean_mass = (1.0 * total_mass / number_atoms).round
        mean_mass
      else
        0
      end
    end
  end
end

Spectrograph.new.operate('atomas_data.txt', AnalysisMethod::MeanAnalysis.new)

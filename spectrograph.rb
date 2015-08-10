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
  end

  def analyze_sample

    # puts "processing next sample"
    @sample.each do |molecule|
      initial_atoms = molecule[0]
      added_atoms = molecule[1]
      atom_counts = {}

      # initialize atom counts
      initial_atoms.each do |atom|
        next unless atom.match /\d+/ # Filter out special atoms
        atom_count = atom_counts[atom] || 0
        atom_counts[atom] = atom_count + 1
      end
      atom_counts = Hash[atom_counts.sort_by{|k,v| k.to_i}]
      # puts "initial atom counts: #{atom_counts.to_s}"

      # process added atoms
      added_atoms.each do |atom|
        next unless atom.match /\d+/ # Filter out special atoms

        # factor this new atom into probabilities
        self.send(@analysis_method.to_sym, atom_counts, atom)

        # add atom to atom counts
        atom_count = atom_counts[atom] || 0
        atom_counts[atom] = atom_count + 1

        atom_counts = Hash[atom_counts.sort_by{|k,v| k.to_i}]
        # puts "  updated atom counts: #{atom_counts.to_s}"
      end
    end
    sorted_frequencies = Hash[@frequencies.sort_by{|k,v| k.to_i}]
    puts "\nFREQUENCIES: #{sorted_frequencies.to_s}"
  end

  def mean_method atom_counts, atom
    mean =
    if atom_counts.length > 0
      total_mass = atom_counts.inject(0){|mass, atom_count| mass.to_i + atom_count[0].to_i * atom_count[1].to_i}
      number_atoms = atom_counts.length
      mean_mass = (1.0 * total_mass / number_atoms).round
    else
      0
    end

    frequency = frequencies(mean, atom)
    @frequencies[mean][atom] = frequency + 1
  end

  def frequencies mean, atom
    @frequencies ||= {}
    @frequencies[mean] = {} unless @frequencies[mean]
    @frequencies[mean][atom] = 0 unless  @frequencies[mean][atom]
    @frequencies[mean][atom]
  end
end

Spectrograph.new.operate('atomas_data.txt', :mean_method)

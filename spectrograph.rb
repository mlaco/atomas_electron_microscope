#!/usr/local/ruby
require 'json'
require 'pry'
require './mean_analysis'
require './results_displayer'

class Spectrograph
  def operate data_file, analysis_method
    # Open the data file
    @analysis_method = analysis_method
    f = File.open(data_file)

    # Calculate conditional probabilities
    while line = f.gets do
      @sample = JSON.parse line
      analyze_sample
    end

    ResultsDisplayer.new(@analysis_method.frequencies).display
  end

  def atom_counts
    @atom_counts ||= {}
  end

  def analyze_sample
    @sample.each do |molecule|
      @atom_counts = {}
      set_initial_atoms molecule[0]
      process_added_atoms molecule[1]
    end
  end

  def set_initial_atoms initial_atoms
      initial_atoms.each do |atom|
        next unless atom.match /\d+/ # Filter out special atoms
        add_atom atom
      end
  end

  def process_added_atoms added_atoms
      added_atoms.each do |atom|
        next unless atom.match /\d+/ # Filter out special atoms

        # factor this new atom into probabilities
        @analysis_method.analyze(atom_counts, atom)

        add_atom atom
      end
  end

  def add_atom atom
      # add atom to atom counts
      atom_count = atom_counts[atom] || 0
      atom_counts[atom] = atom_count + 1
  end
end

Spectrograph.new.operate('atomas_data.txt', AnalysisMethod::MeanAnalysis.new)

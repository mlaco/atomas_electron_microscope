#!/usr/local/ruby
require './analysis_method'

class AnalysisMethod
  class MeanAnalysis < AnalysisMethod
    def analyze atom_counts_arg, atom
      @atom_counts = atom_counts_arg

      atom_frequencies = frequencies_given_metric(mean_atomic_mass)

      atom_frequency = atom_frequencies[atom] || 0
      unless atom_frequency.to_s.match /\d+/
        binding.pry
      end
      atom_frequencies[atom] = atom_frequency + 1
    end

    def mean_atomic_mass

      if atom_counts.length > 0
        # puts "atom counts: #{atom_counts}"
        total_mass = atom_counts.inject(0){|mass, atom_count| mass.to_i + atom_count[0].to_i * atom_count[1].to_i}
        # puts "  total mass: #{total_mass}"

        number_atoms = atom_counts.inject(0){|count, atom_count| count + atom_count[1].to_i }
        # puts "  number atoms: #{number_atoms}"

        mean_mass = (1.0 * total_mass / number_atoms).round

        mean_mass
      else
        0
      end
    end

    def atom_counts
      @atom_counts ||= {}
    end
  end
end

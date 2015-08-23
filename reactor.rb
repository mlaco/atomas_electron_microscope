#!/usr/bin/ruby
require 'pry'
class Reactor
  SPAWN_DIST_WIDTH = 7
  SPAWN_DIST_OFFSET = 3
  PRIORITIES = [4,1,0,2,3,5,6]
  POINTS_FOR_PRIORITY = [90,73,70,33,30,15,3]

  def run
    warm_up
    generate
  end

  def warm_up
    @total_score = 0
    @probabilities = {}
    ring.each do |atom|
      potential_atoms(atom).each do |potential_atom, delta|
        probablize(potential_atom, delta)
      end
    end
    fill_probability_holes
    normalize_probabilities
  end

  def generate
    fluctuation = rng.rand(100.0)
    initial_fluctuation = fluctuation
    probabilities.each do |mass, p|
      if fluctuation <= p
        return mass
      else
        fluctuation -= p
      end
    end

    return 1
  end

  def rng
    @rng ||= Random.new
  end

  def ring
    @ring ||= []
  end

  def ring= ring
    @ring = ring
  end

  def potential_atoms atom
    (0..SPAWN_DIST_WIDTH-1).map{|n| [[atom + n - SPAWN_DIST_OFFSET, 0].max, n] }.delete_if{|e,_| e<1}
  end

  def probablize atom, delta
    probability = probabilities[atom] || 0
    probabilities[atom] = probability + points_for_delta(delta)
  end

  def points_for_delta delta
    POINTS_FOR_PRIORITY[PRIORITIES[delta]]
  end

  def probabilities
    @probabilities ||= {}
  end

  def fill_probability_holes
    extrema = probabilities.keys.minmax
    (extrema[0]..extrema[1]).each do |mass|
        probabilities[mass] = [1, (0.01 * total_score).round].max unless probabilities[mass]
    end
  end

  def normalize_probabilities
    @total_score = probabilities.inject(0){|sum, score| sum + score[1]}
    old_probabilities = probabilities
    old_probabilities.each{|mass, p| probabilities[mass] = (100.0 * p / total_score).round }
    x = probabilities
    probabilities = Hash[x.sort_by{|k,v| k.to_i}]
  end

  def total_score
    @total_score ||= 0
  end

  def total_score= score
    @total_score = score
  end
end

ring = [1,17]
puts "initial ring: #{ring}"
reactor = Reactor.new
(1..20).each do
  reactor.ring = ring
  new_atom = reactor.run
  puts "#{new_atom} >> #{ring}\n\n"
  ring.push new_atom
  ring.shift if ring.length > 13
end

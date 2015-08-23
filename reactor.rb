#!/usr/bin/ruby
require 'pry'
class Reactor
  SPAWN_DIST_WIDTH = 5
  SPAWN_DIST_OFFSET = 2
  POINTS_FOR_DELTA = [1,13,15,3,2]

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
    # puts "initial_fluctuation: #{initial_fluctuation}\ntotal score: #{total_score}\nprobabilities: #{probabilities}"
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
    # (0..SPAWN_DIST_WIDTH-1).map{|n| [[atom + n - SPAWN_DIST_OFFSET, 1].max, n] }
    (0..SPAWN_DIST_WIDTH-1).map do |n|
      val = atom + n - SPAWN_DIST_OFFSET
      if val > 0
        [val, n]
      else
        nil
      end
    end.compact
  end

  def probablize atom, delta
    probability = probabilities[atom] || 0
    probabilities[atom] = probability + POINTS_FOR_DELTA[delta]
  end

  def probabilities
    @probabilities ||= {}
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

ring = [1]
puts "initial ring: #{ring}"
reactor = Reactor.new
# (1..2).each do
while ring.max < 15
  reactor.ring = ring
  new_atom = reactor.run
  puts "#{new_atom} >> #{ring}\n\n"
  ring.push new_atom
  ring.shift if ring.length > 13
end

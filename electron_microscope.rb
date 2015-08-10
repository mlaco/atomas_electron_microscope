#!/usr/bin/ruby

class ElectronMicroscope

  def operate
    playing = true
    new_initial_atoms = true

    @sequences = []

    while playing do

      unless new_initial_atoms # enter play atoms

        puts "Next atom: "
        STDOUT.flush
        atom = gets.chomp

        if atom == ""
          new_initial_atoms = true
        else
          @play_atoms.push atom
        end

      else # need to enter initial atoms

        # Start a new sequence
        @initial_atoms = []
        @play_atoms = []
        @sequence = [@initial_atoms, @play_atoms]
        @sequences.push @sequence

        ring_complete = false
        puts "Enter atoms in ring, empty to continue..."

        while new_initial_atoms do

          STDOUT.flush
          atom = gets.chomp

          if atom == ""
            if @initial_atoms.empty?
              @sequences.pop
              playing = false
            end
            new_initial_atoms = false
          else
            @initial_atoms.push atom
          end
        end
      end
    end
    self
  end # operate

  def save_data
    open('atomas_data.txt', 'a') do |f|
      f.puts @sequences.to_s
    end
  end

end

ElectronMicroscope.new.operate.save_data

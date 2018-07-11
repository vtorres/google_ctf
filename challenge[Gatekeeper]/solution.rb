# It's a media PC! All fully purchased through the online subscription revolution
# empire "GimmeDa$". The PC has a remote control service running that looks like
# it'll cause all kinds of problems or that was written by someone who watched too
# many 1990s movies. You download the binary from the vendor and begin reversing it.
# Nothing is the right way around.

require_relative "../base_helper.rb"

module GoogleCTFSolution
  class Gatekeeper < GoogleCTF::BaseHelper
    def call
      super

      p "⚑ FLAG ⚑: CTF{#{capture_the_flag}}"

      clear_generated_files
    end

    def self.call
      new.call
    end

    private

    def google_ctf_id
      "f7e577b61f5b98aa3c0e453e83c60729f6ce3ef15c59fc76d64490377f5a0b5b"
    end

    def zip_name
      "gatekeeper.zip"
    end

    ##

    def capture_the_flag
      `strings gatekeeper | sed -n 30p | rev`.strip
    end

    def clear_generated_files
      `rm ./gatekeeper.zip ./gatekeeper`
    end
  end
end

GoogleCTFSolution::Gatekeeper.call

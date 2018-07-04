# You really went dumpster diving? Amazing. After many hours, SUCCESS!
# Between what looks like a three week old casserole and a copy of "Relative-Time Magazine",
# you found this important looking letter about the victims PC. However the credentials aren't
# readable - can you still obtain them?

require_relative "../base_helper.rb"

require "yomu"

module GoogleCTFSolution
  class Letter < GoogleCTF::BaseHelper
    def call
      super

      p "⚑ FLAG ⚑: #{capture_the_flag}"

      clear_generated_files
    end

    def self.call
      new.call
    end

    private

    def google_ctf_id
      "5a0fad5699f75dee39434cc26587411b948e0574a545ef4157e5bf4700e9d62a"
    end

    def zip_name
      "letter.zip"
    end

    ###

    def pdf_as_text
      pdf = Yomu.new(File.dirname(__FILE__) + "/challenge.pdf")

      pdf.text
    end

    def capture_the_flag
      matches = pdf_as_text.match("CTF\{.+\}")

      matches[0]
    end

    def clear_generated_files
      `rm ./letter.zip ./challenge.pdf`
    end
  end
end

GoogleCTFSolution::Letter.call

# Using the credentials from the letter, you logged in to the Foobanizer9000-PC.
# It has a floppy drive...why? There is an .ico file on the disk, but it doesn't smell right..

require_relative "../base_helper.rb"

module GoogleCTFSolution
  class Floppy < GoogleCTF::BaseHelper
    def call
      super

      binwalk_file

      p "⚑ FLAG ⚑: #{capture_the_flag}"

      clear_generated_files
    end

    def self.call
      new.call
    end

    private

    def google_ctf_id
      "4e69382f661878c7da8f8b6b8bf73a20acd6f04ec253020100dfedbd5083bb39"
    end

    def zip_name
      "floppy.zip"
    end

    ###

    def binwalk_file
      `binwalk -Meq ./foo.ico`
    end

    def capture_the_flag
      `cat _foo.ico.extracted/driver.txt | grep "CTF"`.strip
    end

    def clear_generated_files
      `rm -rf ./floppy.zip ./_foo.ico.extracted ./foo.ico`
    end
  end
end

GoogleCTFSolution::Floppy.call

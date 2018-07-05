# After unpacking the firmware archive, you now have a binary in which to go hunting.
# Its now time to walk around the firmware and see if you can find anything.

require_relative "../base_helper.rb"

module GoogleCTFSolution
  class Firmware < GoogleCTF::BaseHelper
    def call
      p "it will take a minute to download the attachment"
      super
      p "ok, now lets start"

      create_volume_destination_folder
      extract_ext4_gz
      mount_disk
      unzip_file_to_local_path
      unmount_disk

      p "⚑ FLAG ⚑: #{capture_the_flag}"

      clear_generated_files
    end

    def self.call
      new.call
    end

    private

    def google_ctf_id
      "9522120f36028c8ab86a37394903b100ce90b81830cee9357113c54fd3fc84bf"
    end

    def zip_name
      "firmware.zip"
    end

    # brew install p7zip
    def capture_the_flag
      `cat .mediapc_backdoor_password | tr -d '\n'`
    end

    def create_volume_destination_folder
      `sudo mkdir -p /Volumes/Google_CTF`
    end

    # using ubuntu should be only
    # sudo mount challenge.ext /media/<name>
    # but on macOS should use ext4fuse
    # brew install Caskroom/cask/osxfuse
    # brew install ext4fuse
    def mount_disk
      `sudo ext4fuse ./challenge2.ext4 /Volumes/Google_CTF -o allow_other`
    end

    def extract_ext4_gz
      `7z x -y challenge.ext4.gz`
    end

    def unzip_file_to_local_path
      `sudo 7z x -y /Volumes/Google_CTF/.mediapc_backdoor_password.gz`
    end

    def unmount_disk
      `diskutil unmount force /Volumes/Google_CTF`
    end

    def clear_generated_files
      `rm -f ./firmware.zip ./challenge.ext4.gz ./challenge2.ext4 ./.mediapc_backdoor_password 2>/dev/null`
    end
  end
end

GoogleCTFSolution::Firmware.call

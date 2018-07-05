# Using the credentials from the letter, you logged in to the Foobanizer9000-PC.
# It has a floppy drive...why? There is an .ico file on the disk, but it doesn't smell right..

require_relative "../base_helper.rb"

module GoogleCTFSolution
  class SecurityByObscurity < GoogleCTF::BaseHelper
    def call
      super

      decompress_everything

      p "⚑ FLAG ⚑: #{capture_the_flag}"

      clear_generated_files
    end

    def self.call
      new.call
    end

    private

    def google_ctf_id
      "2cdc6654fb2f8158cd976d8ffac28218b15d052b5c2853232e4c1bafcb632383"
    end

    def zip_name
      "security_by_obscurity.zip"
    end

    ###

    def generated_file
      "password.x.a.b.c.d.e.f.g.h.i.j.k.l.m.n.o.p.a.b.c.d.e.f.g.h.i.j.k.l.m.n.o.p.p.o.n.m.l.k.j.i.h.g.f.e.d.c.b.a.a.b.c.d.e.f.g.h.i.j.k.l.m.n.o.p"
    end

    def nested_file_names
      splitted_file = generated_file.split(".")
      zip_count = splitted_file.count

      # 3 because is where we found the password prompt
      # or zip file with password to crack it
      until_index = 3

      (zip_count).downto(until_index).map do |indexes|
        splitted_file.first(indexes).join(".")
      end
    end

    # brew install p7zip
    #
    # preference for 7z than multiple libs: gzip xz unzip
    def decompress_everything
      p "Unziping nested folders..."

      zip_types = %w[application/zip
                     application/x-xz
                     application/x-bzip2
                     application/x-gzip]

      nested_file_names.each do |file_name|
        file_type = `file --mime-type ./#{file_name} | cut -d " " -f 2 | tr -d '\n'`

        `7z x -y #{file_name} && rm -rf #{file_name}` if zip_types.include?(file_type)
      end
    end

    # brew install fcrackzip
    #
    # we could use a dictionary here but i tried to bruteforce
    # guessing that would not be a superhardcore password
    # so i tryied to run with minimal 1 length password and max 6
    # - more than that i would use a dictionary
    def break_zip_with_fcrackzip
      p "Bruteforcing zip password"

      `fcrackzip -b -u password.x -c aA1! -l1-6 > password_found.txt 2>/dev/null`

      password = `cat password_found.txt | grep "PASSWORD FOUND" | cut -d " " -f 5 | tr -d '\n'`

      p "Password o the zip found! #{password}"

      password
    end

    def capture_the_flag
      unzip_with_password(break_zip_with_fcrackzip)

      `cat ./password.txt | tr -d '\n'`
    end

    def unzip_with_password(password)
      `mv password.x password.zip`

      `7z x -p"#{password}" password.zip`
    end

    def clear_generated_files
      `rm -rf ./password* ./security_by_obscurity.zip`
    end
  end
end

GoogleCTFSolution::SecurityByObscurity.call

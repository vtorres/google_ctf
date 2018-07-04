module GoogleCTF
  class BaseHelper
    GOOGLE_CTF_URL = 'https://storage.googleapis.com/gctf-2018-attachments/'.freeze

    def initialize
      @url = URI.parse("#{GOOGLE_CTF_URL}#{google_ctf_id}")
      @zip_name = zip_name
    end

    def call
      download_file_as_zip
      unzip_the_file

      # calls
    end

    private

    attr_reader :url, :zip_name

    def google_ctf_id
      raise NotImplementedError
    end

    def zip_name
      raise NotImplementedError
    end

    # all initial files url seems to be a zip file, so lets do it automatically
    # verified the file extension type with file command
    # `file --mime-type #{FILE_NAME} | cut -d "/" -f 2 | tr -d '\n'`
    def download_file_as_zip
      `curl #{url} -o #{zip_name} 2>/dev/null`
    end

    def unzip_the_file
      `unzip -o -qq #{zip_name}`
    end
  end
end
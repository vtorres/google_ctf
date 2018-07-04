# Caesar once said, don't stab me… but taking a screenshot of an image sure feels
# like being stabbed. You connected to a VNC server on the Foobanizer 9000,
# it was view only. This screenshot is all that was present but it's gibberish.
# Can you recover the original text?

require_relative "../base_helper.rb"

module GoogleCTFSolution
  class OCRisCool < GoogleCTF::BaseHelper
    def call
      super

      p "Yeap, the OCR didnt get the fully clean text on the image"
      p "but we used a caesar cipher -hint quoted on the text-"
      p "and the result was -> #{capture_the_flag} using ROT 7"
      p "could be transalated to -caesar cipher is a substitution cipher-"
      p "⚑ FLAG ⚑: CTF{caesarcipherisasubstitutioncipher}"

      clear_generated_files
    end

    def self.call
      new.call
    end

    private

    def google_ctf_id
      "7ad5a7d71a7ac5f5056bb95dd326603e77a38f25a76a1fb7f7e6461e7d27b6a3"
    end

    def zip_name
      "ocriscool.zip"
    end

    ###

    # brew install netpbm
    # brew install gocr
    # tried with tesseract and ocr_space but failed miserably
    def image_as_text
      `gocr -i ./OCR_is_cool.png 2>/dev/null`
    end

    # search between parenthesis or brackets
    def strings_to_break
      image_as_text.match(/(?<=\{|\()(.*?)(?=\)|\})/)
    end

    def iterate(x, &block)
      Enumerator.new do |yielder|
        loop do
          yielder << x
          x = block.call(x)
        end
      end.lazy
    end

    def possible_solutions
      caesar_cipher = ->(rotation, text) do
        key = Hash[alphabet.zip(alphabet.rotate(rotation))]
        text.each_char.inject("") { |encrypted, char| encrypted + key[char].to_s }
      end.curry

      strings_to_break.to_a.uniq.map do |str|
        [iterate(str, &caesar_cipher.call(1)).first(alphabet.length)]
      end
    end

    def alphabet
      Array("a".."z")
    end

    def capture_the_flag
      possible_solutions.flatten.map do |result|
        # i had a look in every possible solution
        # and the substition was the only word which
        # have a meaning between the options
        text_that_made_sense = "substitution"

        return "result: {#{result}}" if result.include?(text_that_made_sense)
      end
    end

    def clear_generated_files
      `rm ./ocriscool.zip ./OCR_is_cool.png`
    end
  end
end

GoogleCTFSolution::OCRisCool.call

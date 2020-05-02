require 'fileutils'


plaintext_path = "../in/plaintext"
ciphers_path = "../in"
out = "../out"

ciphers = ["caesar", "vigenere"]

plaintexts = Dir["#{plaintext_path}/**/ascii.txt"]

ciphers.each {|cipher|
	keyfile_path = "#{ciphers_path}/#{cipher}/keys.txt"
	keyfile = File.open(keyfile_path)
	keys = File.readlines(keyfile, chomp: true)


	plaintexts.each {|plaintext|
		plaintext_name = File.basename(File.dirname(plaintext))
		out_path = "#{out}/#{cipher}/#{plaintext_name}"
		FileUtils.mkdir_p out_path

		keys.each_with_index {|key, i|
			ciphertext_path = "#{out_path}/#{i}.txt"
			meta_path = "#{out_path}/#{i}_info.txt"
			encipher_command = "cipher #{cipher} encipher -p #{plaintext} -k #{key} > #{ciphertext_path}"

			puts encipher_command
			system(encipher_command)
		}
	}
}



# This implements a ruby version of python's Crypto.Cipher.XOR
def python_xor(key, string)
  result=""
  codepoints = string.each_codepoint.to_a
  codepoints.each_index do |i|
    result += (codepoints[i] ^ key[i % key.size].ord).chr
  end
  result
end

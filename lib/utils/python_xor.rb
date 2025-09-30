# This implements a ruby version of python's Crypto.Cipher.XOR
# Implementation ~= to ActionController::RequestForgeryProtection.xor_byte_strings
def python_xor(key, str)
  text_bytes = str.bytes
  text_bytes.each_index { |i| text_bytes[i] ^= key[i % key.size].ord }
  text_bytes.pack("C*")
end

class Utils::PythonXor
  ##
end
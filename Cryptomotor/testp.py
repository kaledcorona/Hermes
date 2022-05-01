import sys
import os
import subprocess

list_files = subprocess.run(['./Test'])

print(list_files)


#os.system("echo Hello world")
#for line in sys.stdin:
#    if 'q' == line.rstrip():
#        break
#    print(f'Input: {line}')
#print("Exit")
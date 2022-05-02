import sys
import os
import subprocess


def callCryptoMotor(argument):
    subprocess.run(["../hcryptomotor/bins/hcryptomotor", argument])

callCryptoMotor("")
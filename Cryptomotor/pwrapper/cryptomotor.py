import sys
import os
import subprocess


def callCryptoMotor(argument):
    subprocess.run(["./", argument])

callCryptoMotor("")
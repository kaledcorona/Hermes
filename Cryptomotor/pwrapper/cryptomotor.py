#!/usr/bin/python
import sys
import os
import subprocess
import time
import select


def main():
    print("--- Cryptomotor v1.0 ---")
    print("Selecciona una de las opciones")
    print("1.--> Generar nuevas claves de encriptacion")
    print("2.--> Encriptar un documento")
    print("3.--> Descencriptar un documento")
    print("4.--> Firmar un documento")
    print("5.--> Verificar un documento")
    print("otro --> Salir")
    argumento = input()
    if (argumento == "1"):
        callCryptoMotor()
    elif (argumento == "4"):
        callHashFunction("../hcryptomotor/test/testfiles/test.pdf")

def callCryptoMotor():
    subprocess.run(["../hcryptomotor/.stack-work/install/x86_64-linux-tinfo6/0ede982d3f8e41d7cefbca13c6f922878b5a782887477c6d0108f39e91a3b7a1/8.10.7/bin/hcryptomotor-genkey"])
    print("LLaves generadas con exito")
    return 0

def callHashFunction(filepath):
    callhash = subprocess.Popen(["../hcryptomotor/bins/sha384sum", filepath], stdout=subprocess.PIPE)
    handler = select.poll()
    handler.register(callhash.stdout, select.POLLIN)
    hashString = callhash.stdout.readline()
    getHashFromString(hashString)

def getHashFromString(hashString):
    hash = hashString.split()
    print(str(hash[0] == "1"))



main()

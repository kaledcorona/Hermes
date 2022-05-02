import sys
import os
import subprocess

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

def callCryptoMotor():
    subprocess.run(["../hcryptomotor/bins/hcryptomotor"])

main()
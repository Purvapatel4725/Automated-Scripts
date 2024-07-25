#!/usr/bin/python3
import gmpy2
from gmpy2 import isqrt, gcd, invert
from cryptography.hazmat.primitives.asymmetric import rsa
from cryptography.hazmat.primitives import serialization

def factorize(n):
    # since even nos. are always divisible by 2, one of the factors will always be 2
    if (n & 1) == 0:
        return (n // 2, 2)

    # isqrt returns the integer square root of n
    a = isqrt(n)

    # if n is a perfect square the factors will be (sqrt(n), sqrt(n))
    if a * a == n:
        return a, a

    while True:
        a = a + 1
        bsq = a * a - n
        b = isqrt(bsq)
        if b * b == bsq:
            break

    return a + b, a - b

def generate_rsa_components(n, e):
    p, q = factorize(n)
    print(f"The factors of {n} are p = {p} and q = {q}.")

    # Calculate the totient φ(n) = (p-1) * (q-1)
    phi_n = (p - 1) * (q - 1)

    # Ensure e and phi_n are coprime
    if gcd(e, phi_n) != 1:
        raise ValueError("e and φ(n) are not coprime!")

    # Calculate the private exponent d
    d = invert(e, phi_n)

    return p, q, d

def create_pem_private_key(n, e):
    p, q, d = generate_rsa_components(n, e)
    
    # Convert gmpy2.mpz to int explicitly
    p_int = int(p)
    q_int = int(q)
    d_int = int(d)

    # Calculate dmp1, dmq1, and iqmp
    dmp1 = d_int % (p_int - 1)
    dmq1 = d_int % (q_int - 1)
    iqmp = invert(q_int, p_int)

    # Ensure all values are integers
    p = int(p)
    q = int(q)
    d = int(d)
    dmp1 = int(dmp1)
    dmq1 = int(dmq1)
    iqmp = int(iqmp)

    # Create RSA key object using the cryptography library
    key = rsa.RSAPrivateNumbers(
        p=p,
        q=q,
        d=d,
        dmp1=dmp1,
        dmq1=dmq1,
        iqmp=iqmp,
        public_numbers=rsa.RSAPublicNumbers(e, n)
    ).private_key()

    # Export the private key in PEM format
    private_key_pem = key.private_bytes(
        encoding=serialization.Encoding.PEM,
        format=serialization.PrivateFormat.TraditionalOpenSSL,
        encryption_algorithm=serialization.NoEncryption()
    )
    return private_key_pem

# Example usage
n = 123435  # Replace this with your actual value of n
e = 65537  # Commonly used public exponent

pem_private_key = create_pem_private_key(n, e)

print("Private key in PEM format:")
print(pem_private_key.decode())

# Save the PEM key to a file (optional)
with open("private_key.pem", "wb") as f:
    f.write(pem_private_key)

# RSA Key Manipulation Guide

If you have the public key file saved as `id_rsa.pub`, follow these steps to retrieve the modulus `N` and generate a private PEM key for SSH login.

## Steps

1. **Extract the modulus `N`**:
   Use the script `publickeytofinN.py` to extract `N` from your public key file.

    ```sh
    python3 publickeytofindN.py id_rsa.pub
    ```

2. **Copy the modulus `N`**:
   After running the above script, copy the output value of `N`.

3. **Generate the private PEM key**:
   Paste the copied `N` into the input of `privatekeypem.py` to factorize and solve the RSA, then save it as a PEM private key.

    ```sh
    python3 privatekeypem.py
    ```

   Follow the prompts to paste the value of `N`.

4. **Use the generated PEM key**:
   The resulting PEM file can be used to log in to the SSH server. Also, make sure to assign proper permissions to the key file.

    ```sh
    $ ssh -i private_key.pem user@hostname
    ```

## Important Notes

- **Security**: Ensure that your private key is kept secure and not shared with unauthorized parties.
- **Permissions**: Adjust the file permissions of your private key to ensure it is only readable by you.

    ```sh
    chmod 600 private_key.pem
    ```

- **Ethical Use**: Use these scripts responsibly and only with proper authorization.

---

**Author**: Purva Patel

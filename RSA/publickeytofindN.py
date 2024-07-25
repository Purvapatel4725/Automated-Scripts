import subprocess

def extract_rsa_modulus(filename):
    # Construct the first command to extract the modulus from the RSA public key
    command1 = f'ssh-keygen -e -m PKCS8 -f {filename} | openssl rsa -pubin -noout -modulus'

    # Execute the first command and capture the output
    process1 = subprocess.Popen(command1, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout1, stderr1 = process1.communicate()

    # Decode the output (modulus) and strip the "Modulus=" prefix
    modulus = stdout1.decode().strip().split('=')[1]

    return modulus

def generate_final_output(modulus):
    # Construct the second command with the provided modulus
    command2 = f'echo "ibase=16; {modulus}" | BC_LINE_LENGTH=0 bc'

    # Execute the second command with the modulus as input
    process2 = subprocess.Popen(command2, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout2, stderr2 = process2.communicate()

    # Decode the output (final result)
    final_output = stdout2.decode().strip()

    return final_output

def main():
    # Prompt the user for the RSA public key filename
    filename = input("Enter the filename of the RSA public key (e.g., id_rsa.pub): ")

    try:
        # Get the RSA modulus from the public key
        modulus = extract_rsa_modulus(filename)
        print(f"RSA Modulus extracted from {filename}: Modulus={modulus}")

        # Generate the final output using the modulus
        final_output = generate_final_output(modulus)

        # Print the final output
        print("Final Output:")
        print(final_output)

    except subprocess.CalledProcessError as e:
        print(f"Error executing command: {e}")
        return

if __name__ == "__main__":
    main()

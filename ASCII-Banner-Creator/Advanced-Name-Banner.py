import pyfiglet
from termcolor import colored, cprint

def print_banner(text, font="standard", color="white", attrs=None, to_file=False, filename="banner.txt"):
    if attrs is None:
        attrs = []
        
    # Generate ASCII art using pyfiglet
    banner = pyfiglet.figlet_format(text, font=font)
    
    # Print colored ASCII art
    colored_banner = colored(banner, color=color, attrs=attrs)
    print(colored_banner)
    
    # Save to file if required
    if to_file:
        with open(filename, 'w') as f:
            f.write(banner)

def main():
    # Get user input for text
    text = input("Enter the text for the banner: ")
    
    # Get user input for font
    fonts = pyfiglet.FigletFont.getFonts()
    print("\nAvailable fonts:")
    for i, font in enumerate(fonts):
        print(f"{i}. {font}")
    
    font_choice = input("\nEnter the font number (or press Enter for default): ")
    font = fonts[int(font_choice)] if font_choice.isdigit() and int(font_choice) < len(fonts) else "standard"
    
    # Get user input for color
    colors = ['grey', 'red', 'green', 'yellow', 'blue', 'magenta', 'cyan', 'white']
    print("\nAvailable colors:")
    for i, color in enumerate(colors):
        print(f"{i}. {color}")
    
    color_choice = input("\nEnter the color number (or press Enter for default): ")
    color = colors[int(color_choice)] if color_choice.isdigit() and int(color_choice) < len(colors) else "white"
    
    # Get user input for text attributes
    attributes = ['bold', 'dark', 'underline', 'blink', 'reverse', 'concealed']
    print("\nAvailable attributes:")
    for i, attr in enumerate(attributes):
        print(f"{i}. {attr}")
    
    attr_choice = input("\nEnter the attribute numbers separated by comma (or press Enter for none): ")
    attrs = [attributes[int(a)] for a in attr_choice.split(',') if a.isdigit() and int(a) < len(attributes)]
    
    # Get user input for saving to file
    to_file = input("\nDo you want to save the banner to a file? (y/n): ").lower() == 'y'
    filename = input("Enter the filename (default: banner.txt): ") if to_file else "banner.txt"
    
    # Print the banner with the specified options
    print_banner(text, font, color, attrs, to_file, filename)

if __name__ == "__main__":
    main()

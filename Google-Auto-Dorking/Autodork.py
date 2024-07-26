print(r"""
     ____                          ____       _       _ 
    |  _ \ _   _ _ ____   ____ _  |  _ \ __ _| |_ ___| |                                                                                                                    
    | |_) | | | | '__\ \ / / _` | | |_) / _` | __/ _ \ |                                                                                                                    
    |  __/| |_| | |   \ V / (_| | |  __/ (_| | ||  __/ |                                                                                                                    
    |_|    \__,_|_|    \_/ \__,_| |_|   \__,_|\__\___|_|                                                                                                                                                                                                                                                                       
          """)


def get_input(prompt, options=None, default=""):
    if options:
        print(prompt)
        for i, option in enumerate(options, start=1):
            print(f"{i}. {option}")
        while True:
            user_input = input(f"Choose an option (1-{len(options)}) or press Enter for default: ")
            if not user_input:
                return default
            if user_input.isdigit() and 1 <= int(user_input) <= len(options):
                return options[int(user_input) - 1]
            else:
                print(f"Invalid input. Please enter a number between 1 and {len(options)}.")
    else:
        user_input = input(prompt + ": ")
        return user_input.strip() if user_input else default

def generate_google_search_query():
    # Predefined options
    terms_locations = ["title", "body", "url", "links"]
    file_types = ["pdf", "doc", "docx", "xls", "xlsx", "ppt", "pptx", "txt", "csv", "jpg", "png", "gif"]

    # Taking inputs from the user
    important_words = get_input("Enter important words (separate by space)")
    exact_phrase = get_input("Enter exact words or phrase")
    any_words = get_input("Enter any of the words (separate by comma, words will be combined with OR)")
    none_words = get_input("Enter words to exclude (separate by space)")
    number_range = get_input("Enter number range (e.g., 100..200)")
    site_or_domain = get_input("Enter site or domain")
    terms_appearing = get_input("Enter where terms should appear", terms_locations)
    file_type = get_input("Enter file type (e.g., pdf)", file_types)

    # Building the query
    query_parts = []

    if important_words:
        query_parts.append(important_words)
    if exact_phrase:
        query_parts.append(f'"{exact_phrase}"')
    if any_words:
        query_parts.append(f'({" OR ".join(any_words.split(","))})')
    if none_words:
        query_parts.append(f'-{" -".join(none_words.split())}')
    if number_range:
        query_parts.append(number_range)
    if site_or_domain:
        query_parts.append(f'site:{site_or_domain}')
    if terms_appearing:
        if terms_appearing == "title":
            query_parts.append(f'intitle:{important_words}')
        elif terms_appearing == "body":
            query_parts.append(f'intext:{important_words}')
        elif terms_appearing == "url":
            query_parts.append(f'inurl:{important_words}')
        elif terms_appearing == "links":
            query_parts.append(f'inanchor:{important_words}')
    if file_type:
        query_parts.append(f'filetype:{file_type}')

    # Joining all parts to form the final query
    final_query = ' '.join(query_parts)
    
    return final_query

if __name__ == "__main__":
    search_query = generate_google_search_query()
    print("\nGenerated Google Search Query:\n")
    print(search_query)

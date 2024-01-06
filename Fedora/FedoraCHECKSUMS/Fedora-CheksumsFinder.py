#!/usr/bin/env python3
#emreYbs

# This script will find the Fedora 39 Checksums URLs from the mirror sites.
# It will also download the URLs to a .csv and .txt file.
# It will also scan the subdomains for the base URL.
# The official Fedora website doesn't have the checksums for Python Classroom Lab for months!
# So, I had to find the checksums from the mirror sites.
# Official Fedora Website has the CHECKSUM for Workstation
# https://download.fedoraproject.org/pub/fedora/linux/releases/39/Workstation/x86_64/iso/Fedora-Workstation-39-1.5-x86_64-CHECKSUM
# I wrote this script to find the checksums for Python Classroom Lab.But you can find the checksums for other Fedora 39 alternatives too.
# Like Spins, Labs, Server, Silverblue, Everything, Container, Cloud, Workstation
# https://mirror.yandex.ru/fedora-secondary/releases/39/Labs/aarch64/images/ I found the Checksum here
# Checksums for other Distros: https://mirror.yandex.ru/fedora-secondary/releases/39/
# If you only need Python Classroom Lab, you can use this URL: https://mirror.yandex.ru/fedora-secondary/releases/39/Labs/aarch64/images/
# BTW, Yandex is also an official Mirror site for Fedora. https://mirrors.fedoraproject.org/publiclist/
# Check all mirrors according to countries: https://admin.fedoraproject.org/mirrormanager/mirrors/Fedora/39/aarch64

##emreybs says:"If you feel like being lazy, then just use the Fedore Writer tool to write the ISO to a USB stick.It automatically checks the checksums:)"

import requests
from bs4 import BeautifulSoup
import csv
from urllib.parse import urlparse
from time import sleep

print("\n\t\t★彡 Fedora39 sha256Checksums 彡★\n")
sleep(1)
print("This script will find the Fedora 39 Checksums URLs from the mirror sites.")
sleep(1)
print("It will also download the URLs to a .csv and .txt file.")
sleep(1)
print("It will also scan the subdomains for the base URL.")
sleep(1)
print("The official Fedora website doesn't show the checksums for -Python Classroom Lab- easily, for months!")
sleep(1)
print("So, I had to find the checksums from the mirror sites by fuzzing the URLs.")
sleep(2)

# Official Fedora Website has the CHECKSUM for Workstation 
# https://download.fedoraproject.org/pub/fedora/linux/releases/39/Workstation/x86_64/iso/Fedora-Workstation-39-1.5-x86_64-CHECKSUM
# I wrote this script to find the checksums for Python Classroom Lab.But you can find the checksums for other Fedora 39 alternatives too.
# Like Spins, Labs, Server, Silverblue, Everything, Container, Cloud, Workstation


def find_checksums_url(base_urls):
    for base_url in base_urls:
        response = requests.get(base_url)
        soup = BeautifulSoup(response.content, 'html.parser')
        anchor_tags = soup.find_all('a')
        for tag in anchor_tags:
            href = tag.get('href')
            if 'CHECKSUMS' in href or 'CHECKSUM' in href or 'checksum' in href:
                checksums_url = base_url + href
                print(f"\nURL with CHECKSUMS: {checksums_url}")
                return checksums_url

    print("No URL with CHECKSUMS found yet...\n")
    return None

def subdomain_scan(base_url):
    response = requests.get(base_url)
    print(f"\n\tScanning subdomains for {base_url}")
    sleep(1)
    print(f"Response code: {response.status_code}")
    if response.status_code == 200:
        print(f"Subdomain scan successful for {base_url}")
    elif response.status_code in [403, 401, 400]:
        print(f"Subdomain scan failed for {base_url}")

 # You will get a 404 for a valid URL if the subdomain scan fails and it will fail for a reason.
    #In order to keep the code simple and since I don't need to use it again and again, I didn't add the code to handle the 404 error.
    # Just check the downloaded .txt file and find the fuzzed URL's and you'll find the Fedora 39 Checksums URLs.    
    elif response.status_code == 404:
        sleep(2)
        print("\n\tYou will get a Failed message. Don't worry. Expected behavior.\n")
        sleep(2)
        print(f"\nSubdomain scan failed for {base_url}")
        sleep(1)
        print("However, the URL may still be valid. Check the URL manually.")
        sleep(1)
        print("The downloaded .csv and .txt files will have the valid URLs.\n")
        # At least when I wrote this simple script for the reason to find the missing FEdora 39 Python Classroom CHECKSUMS.
        # Fedora Official website didn't have the checksums for Python Classroom Lab for months!
        # So, I had to find the checksums from the mirror sites.
        sleep(2)
    else:
        print("Done.")

def is_valid_url(url):
    try:
        if not url:
            return False
        result = urlparse(url)
        if not result.scheme:
            url = 'https://' + url  # Add 'https://' as the default scheme
            result = urlparse(url)
        return all([result.scheme, result.netloc])
    except ValueError:
        return False

base_url = "https://dl.fedoraproject.org/pub/alt/releases/39/FUZZ/"
# Normally I first tried this URL: https://mirror.yandex.ru/fedora-secondary/releases/39/FUZZ/
# But some people may prefer other mirrors depending on their location or other reasons.So changed the Base_URL to a more general one.
# https://mirror.yandex.ru/fedora-secondary/releases/39/Labs/aarch64/images/ I found the Checksum here
# Checksums for other Distros: https://mirror.yandex.ru/fedora-secondary/releases/39/
# If you only need Python Classroom Lab, you can use this URL: https://mirror.yandex.ru/fedora-secondary/releases/39/Labs/aarch64/images/   

# Fuzz the base_url
fuzzed_urls = []
fuzz_words = ["Cloud", "Container", "Everything", "Labs", "Server", "Silverblue", "Spins", "Workstation"]
# Add any other name if in the Future Fedora adds more alternatives. For January 2024, these are the alternatives.
fuzzed_urls = [base_url.replace("FUZZ", word) for word in fuzz_words]

checksums_url = find_checksums_url(fuzzed_urls)

def download_urls_to_files(fuzzed_urls):
    with open('Fedora39Checksums-urls.csv', 'w', newline='') as csv_file:
        writer = csv.writer(csv_file)
        if csv_file.tell() == 0:  # Check if the file is empty
            writer.writerow(['Index', 'URL'])  # Add column headers
        for index, url in enumerate(fuzzed_urls, start=1):
            writer.writerow([index, url])
            print(f"URL {url} written to CSV file.")

    with open('Fedora39Checksums-urls.txt', 'a') as txt_file:
        for url in fuzzed_urls:
            txt_file.write(f"URL: {url}\n")
            print(f"URL {url} written to TXT file.\n")

if fuzzed_urls:
    download_urls_to_files(fuzzed_urls)

subdomain_scan(base_url)

fuzzed_urls = list(set(fuzzed_urls))

print("Exiting...")
sleep(1)


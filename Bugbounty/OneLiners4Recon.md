#!/bin/bash
#github.com/emreYbs/my-auto-install-bash-scripts
#Be sure to have the tools and install if that tool is missing. I tested on an Ubuntu and Debian based distro. "jq" tool can be missing in some distro repos.



# Extract subdomains from crt.sh
echo "targetdomain.com" | xargs -I testdomain curl -s "https://crt.sh/?q=%.testdomain&output=json" | jq '.name_value' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u

# Extract subdomains from certspotter.com
echo "targetdomain.com" | xargs -I testdomain curl -s https://certspotter.com/api/v0/certs\?domain\=testdomain | jq '.[].dns_names[]' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u

# Enumerate hosts from SSL Certificate
echo | openssl s_client -connect https://targetdomain.com:443  | openssl x509 -noout -text | grep DNS

# Query Google DNS via HTTPS
echo "targetdomain.com" | xargs -I domain proxychains curl -s "https://dns.google.com/resolve?name=domain&type=A" | jq .

# Use CommonCrawl to find endpoints on a site
echo "targetdomain.com" | xargs -I domain curl -s "http://index.commoncrawl.org/CC-MAIN-2018-22-index?url=*.domain&output=json" | jq -r .url | sort -u

# NMAP scanning via Shodan (unfinished, needs xargs)
nmap --script shodan-api --script-args 'http://shodan-api.target =$IP,shodan-api.apikey=API_KEY'
# Extract subdomains from VirusTotal
echo "targetdomain.com" | xargs -I domain curl -s "https://www.virustotal.com/ui/domains/domain/subdomains?limit=40" | jq -r '.data[].id' | sort -u

# Find open ports using Nmap
nmap -p- targetdomain.com | grep ^[0-9] | cut -d '/' -f 1 | tr '\n' ',' | sed 's/,$//'

#If you cannot use Nmap,use this Bash script with regex command for Banner Grabbing. USeful in CTFs
netstat -nlt | grep 'tcp ' | grep -Eo "[1-9][0-9]*" | xargs -I {} sh -c "echo "" | nc -v -n -w1 127.0.0.1 {}"

# Enumerate DNS records using dig
dig targetdomain.com any +noall +answer

# Discover hidden directories using Gobuster
gobuster dir -u targetdomain.com -w /path/to/wordlist.txt -t 50 -q -e -k -x php,html,txt

# Extract email addresses from a webpage
curl -s targetdomain.com | grep -Eio '\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b' | sort -u

# Check if a website is vulnerable to SQL injection
sqlmap -u "https://targetdomain.com/page?id=1" --batch --level=5 --risk=3

# Scan for open S3 buckets using AWS CLI
aws s3 ls | awk '{print $3}'

# You can combine these separate commands in Oneliner, but I prefer to use them separately
# Extract metadata from PDF files
exiftool targetfile.pdf

# Extract metadata from image files
exiftool targetimage.jpg

# Extract metadata from Office documents
exiftool targetdoc.docx

# Extract metadata from audio files
exiftool targetaudio.mp3

# Extract metadata from video files
exiftool targetvideo.mp4

# Extract metadata from compressed files
exiftool targetzip.zip

# Use WhatWeb with verbose output to gather detailed information about the target website
whatweb -v targetdomain.com

# fuff tool is great for pentesters or bug bounty hunters. Check its Github Repo for more detailed uses: https://github.com/ffuf/ffuf
# A more advanced use of ffuf command in oneliner form that I use for bug bounty hunting
#Have jq installed on your system to use this command:sudo apt install jq
#use the -of flag to specify the output format. You can use csv, ejson, json, html, md, or yaml.
ffuf -u https://targetdomain.com/FUZZ -w /path/to/wordlist.txt -mc all -fc 404 -of csv -o output.csv && ffuf -u https://targetdomain.com/FUZZ -w /path/to/wordlist.txt -mc all -fc 404 -of ejson -o output.json && jq -r '.results[] | [.url, .status, .length, .words, .lines] | @csv' output.json > output.txt

#As Oneliner
echo "https://targetdomain.com/FUZZ" | xargs -I % ffuf -u % -w /path/to/wordlist.txt -mc all -fc 404 -of ejson -o output.json && jq -r '.results[] | [.url, .status, .length, .words, .lines] | @csv' output.json > output.txt

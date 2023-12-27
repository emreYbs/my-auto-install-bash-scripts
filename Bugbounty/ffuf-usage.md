### Example : fufr common.txt example.com
- **OneLiner:** </br>
- Let's define the Bash Script with a function called "fufr()":  </br>
````fufr() { ffuf -c -w /SecLists/Discovery/Web-Content/$1 -u http://$2/FUZZ -recursion; }````
  
  **Explanation of this OneLiner and also also _ffuf_ tool:** </br>
  
If you do not have it, you can install _**ffuf**_ ````sudo apt-get install ffuf```` </br>
For the content discovery wordlist, you also need to have: _**SecLists**_  ````git clone https://github.com/danielmiessler/SecLists.git````

The normal usage of this tool is : ````ffuf -w /path/to/wordlist -u http://targetwebsite.com/FUZZ````, but with this oneliner you can be a little faster and it's a little easier to use in terms of syntax.

**_ffuf*__ tool is great for application security testing and thereby bugbounty, sometimes you may need to use the parameters to get more content, so this longer version with added parameters enable more content discovery.
- -mc: `ffuf` will consider as "hit"
- -fc: HTTP response codes that ffuf will filter out by ignoring certain types of responses
- -e: Specifies the extensions. Good for discovering files with specific extensions.
- -t: Specifies the number of concurrent threads that `ffuf` will use. Increase the number for faster discovery BUT be careful, for the server, you also increase the load.
- -recursion: As the name indicates, -recursion`: Enables recursive fuzzing. `ffuf` will fuzz both the directory and each subdirectory that it discovers.
- -v: verbose mode
- -H: specify custom headers ````ffuf -w /path/to/wordlist -u http://targetwebsite.com/FUZZ -H "User-Agent: MyCustomUserAgent" -H "Cookie: sessionid=123456"````
  
````ffuf -w /path/to/wordlist -u http://targetwebsite.com/FUZZ -mc 200,204,301,302,307,401,403 -fc 404 -e .php,.html,.js -t 50 -recursion -v````

- -fc: ignore/filter out 404s and match all HTTP response/status codes
````ffuf -u https://targetdomain.com/FUZZ -w **/path/to/wordlist.txt** -mc all **-fc** 404```` 
- _Arrange the **PATH** to your wordlist PATH and the target URL._

### Use ffuf to find subdomains
````ffuf -w /path/to/wordlist.txt -u https://targetdomain.com -H "Host: FUZZ.targetdomain.com" -fs 4242````

### A more advanced use of ffuf command in oneliner form that I use for bug bounty hunting
- Have jq installed on your system to use this command:````sudo apt install jq```` for Debian, Ubuntu based distros. You can also use````brew````for MacOs

- use the **-o** or **-of** _flag_ to specify the output format. You can use **csv, ejson, json, html, md, or yaml**.
````ffuf -u https://targetdomain.com/FUZZ -w /path/to/wordlist.txt -mc all -fc 404 -of csv -o output.csv && ffuf -u https://targetdomain.com/FUZZ -w /path/to/wordlist.txt -mc all -fc 404 -of ejson -o output.json && jq -r '.results[] | [.url, .status, .length, .words, .lines] | @csv' output.json > output.txt````
- And let me remind again: _Arrange the **PATH** to your wordlist PATH and the target URL._

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

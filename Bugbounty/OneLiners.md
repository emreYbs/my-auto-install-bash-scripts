### Example : fufr common.txt example.com
- **OneLiner:** </br>
- Let's define the Bash Script with a function called "fufr()":  </br>
````fufr() { ffuf -c -w /SecLists/Discovery/Web-Content/$1 -u http://$2/FUZZ -recursion; }````

If you do not have it, you can install _**ffuf**_ ````sudo apt-get install ffuf```` </br>
For the content discovery wordlist, you also need to have: _**SecLists**_  ````git clone https://github.com/danielmiessler/SecLists.git````

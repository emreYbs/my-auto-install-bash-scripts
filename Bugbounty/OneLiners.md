fufr() { ffuf -c -w /SecLists/Discovery/Web-Content/$1 -u http://$2/FUZZ -recursion; }

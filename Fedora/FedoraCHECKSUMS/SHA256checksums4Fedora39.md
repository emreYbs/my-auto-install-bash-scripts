
**NOTE:** In this repo, you can find a simple Python script I had to write. Sayin "had to" because I was tired of searching for the Fedora 39 Python Classroom's SHA256 sum to verify the downloaded the iso from the official site. Fedora Official website, weirdly, doesn't provide the all CHECKSUMS for LABS editions. You need to brute force the subdomains, which I didn't want to do. So this simple Python script can help you find the CHECKSUMS links. However, I also provided the offical 256Sum for a quick check.

# Fedora 39 Checksums
### TL;DR : 
- You can easily find the Python Classroom or other LABS version of Fedora 39 here.
https://dl.fedoraproject.org/pub/alt/releases/39/Labs/x86_64/iso/
https://dl.fedoraproject.org/pub/alt/releases/39/Labs/x86_64/iso/Fedora-Labs-39-1.5-x86_64-CHECKSUM
 

You can find all official mirror sites for Fedora here: https://admin.fedoraproject.org/mirrormanager/mirrors/Fedora/39/aarch64
 </br>
 
- Say you need Fedora-Labs-39-1.5-aarch64-CHECKSUM but you cannot find it in the official Fedora Website. Weirdly, the CHECKSUMS for LABS and alternative downloads may be hidden in the Fedora Website.
- So you can use the Mirror sites to get the CHECKSUMS for Fedora39 and try the closest country mirror. </br>
- You can also use this simple Python script that I wrote, I chose the official mirror site in Russia since it has the Checksum for Python Classsroom iso
- Turkish mirror has different spins but not the Python Classroom: https://ftp.linux.org.tr/fedora/releases/39/Spins/x86_64/iso/

### Fedora-Python-Classroom-39-1.5.aarch64.raw.xz
**SHA256**:
  - ee5db44bfe1db22f95ab9205fe7bd688378e5a1f94ce944153507ab737ea4674

### Fedora-Python-Classroom-Live-x86_64-39-1.5.iso
**SHA256**:
- 20b660ac93516c2b82a8f7105151df12c363fd18b358a7cd6a5baaa8d05b8796
  
 Since Fedora Official website gives the Fedora Workstation 39 CHECKSUMs but ignores some other LABS distros. I found some other valid mirror websites to check/verify the downloaded the iso files:
https://mirror.yandex.ru/fedora-secondary/releases/39/Labs/aarch64/images/ </br>
_You can find the Fedora 39 and all of the alternatives here._
 </br>

The location close to my country also lacks the Python Classroom version of Fedora, so I provided the **Russian mirror site**.
You can also try the script I wrote to find the URLS based on Fedora official website and find the Checksums by fuzzing.

- You can find the CHECKSUMS of Fedora 39 and its alternatives like Spins, Labs here:  </br>
   https://mirror.yandex.ru/fedora-secondary/releases/39/Cloud      
   https://mirror.yandex.ru/fedora-secondary/releases/39/Container      
   https://mirror.yandex.ru/fedora-secondary/releases/39/Everything      
   https://mirror.yandex.ru/fedora-secondary/releases/39/Labs      
   https://mirror.yandex.ru/fedora-secondary/releases/39/Server      
   https://mirror.yandex.ru/fedora-secondary/releases/39/Silverblue      
   https://mirror.yandex.ru/fedora-secondary/releases/39/Spins      
   https://mirror.yandex.ru/fedora-secondary/releases/39/Workstation/

  
**Verify your download**  </br>
Verify your download for security and integrity using the proper checksum file. If there is a good signature from one of the Fedora keys, and the SHA256 checksum matches, then the download is valid.

Download the checksum file into the same directory as the image you downloaded.

**Import Fedora's GPG key(s)**  </br>

````curl -O https://fedoraproject.org/fedora.gpg````

**Current GPG keys**
- Fedora Rawhide  </br>

**id:** rsa4096/A15B79CC 2023-01-24  </br>
**Fingerprint:**
115DF9AEF857853EE8445D0A0727707EA15B79CC  </br>
 </br>
**DNS OpenPGPKey:**
````4d0cd6e4349d5979387749daf5995f20d0de7f7b2fdfdc76d7eb21a1._openpgpkey.fedoraproject.org````
 </br>
- Fedora 39
**id:** ````rsa4096/18B8E74C 2022-08-09````
   </br>
**Fingerprint:**
````E8F23996F23218640CB44CBE75CF5AC418B8E74C````
 </br>

**DNS OpenPGPKey:**
  ````48cb71516f035e33db6249d81d145d8b9198da654fbfbcf16c06104d._openpgpkey.fedoraproject.org````
 </br>   

**Verify the checksum file is valid**  </br>

````gpgv --keyring ./fedora.gpg Fedora-Spins-39-1.5-aarch64-CHECKSUM````
Verify the checksum matches

````sha256sum -c Fedora-Spins-39-1.5-aarch64-CHECKSUM````

**If the output states that the file is valid, then you can trust and use it.**


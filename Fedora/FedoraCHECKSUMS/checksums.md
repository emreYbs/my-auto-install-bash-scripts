
# Fedora 39 Checksums
 </br>
 
- Fedora-Labs-39-1.5-aarch64-CHECKSUM  </br>

### Fedora-Python-Classroom-39-1.5.aarch64.raw.xz
**SHA256**:
  - ee5db44bfe1db22f95ab9205fe7bd688378e5a1f94ce944153507ab737ea4674
  
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


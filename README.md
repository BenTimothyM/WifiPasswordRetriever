
# 🔑 WifiPasswordRetriever (Wi-Fi Password Retriever Utility)

![Batch Script](https://img.shields.io/badge/Batch_Script-4D4D4D?style=for-the-badge&logo=windows&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge) 

**WifiPasswordRetriever** is a lightweight, native Windows Batch script (`.bat`) designed to view and retrieve saved Wi-Fi passwords using Netsh.

> **🌱 Learning Repository:**
> This repository serves as a **learning playground** for Windows network administration and batch automation. [cite_start]The code demonstrates practical OS-level network queries (like `netsh wlan show profiles`), string filtering with `findstr`, and automatic UAC privilege elevation[cite: 24, 28]. It is a great starting point for anyone looking to learn IT support automation and batch scripting!

## 📖 Project Description

Have you ever forgotten the Wi-Fi password to a network you've already connected to? Finding saved Wi-Fi passwords through the Windows GUI requires navigating through multiple Network & Sharing Center menus, which can be tedious.

**WifiPasswordRetriever** solves this by offering a straightforward, command-line interface. By simply running this script, it will list all the Wi-Fi profiles saved on your PC and allow you to retrieve the plain-text password for any specific network instantly. No third-party software installations are required.

## ✨ Key Features

- ⚡ **Profile Listing:** Automatically lists all available saved Wi-Fi profiles on your machine[cite: 28].
- 🔑 **Password Retrieval:** Instantly extracts and displays the clear-text password (`Key Content`) for the selected network[cite: 30].
- 🔓 **Open Network Detection:** Gracefully handles open networks by indicating when no password is set.
- 🛡️ **Auto-Elevation:** The script automatically detects if it lacks Administrator privileges and requests them via UAC before running to ensure commands execute properly[cite: 24].
- 🔁 **Interactive Loop:** Includes a looping menu that allows you to check another Wi-Fi network without needing to restart the script[cite: 32].
- 🛑 **Error Handling:** Built-in error checking to verify if the inputted profile actually exists before attempting retrieval.

## 💻 Tech Stack

- **Language:** Windows Batch Scripting (`.bat` / `.cmd`)
- **Environment:** Native Windows Command Prompt (CMD)

## 🚀 Installation

Since this is a native batch script, the setup is incredibly simple:

1. **Clone the Repository**
   Open your terminal/CMD and run:
   ```git clone [https://github.com/BenTimothyM/WifiPasswordRetriever.git]```

2. **Run the Script**
Navigate to the cloned folder and locate the `WifiPasswordRetriever.bat` file.

## 💡 How to Use

> ⚠️ **IMPORTANT: Administrator Privileges Required**
> This script requires elevated permissions to view security keys. The script is designed to automatically prompt for these permissions if you don't run it as admin initially.
> 
> 

You can execute the script in two ways:

**Method 1: GUI (Recommended)**

1. Navigate to the folder where you placed `WifiPasswordRetriever.bat`.
2. Double-click the file.
3. Click **"Yes"** on the User Account Control (UAC) prompt if it asks for elevated privileges.
4. View the list of available Wi-Fi profiles.
5. Type the name of the profile you want to retrieve the password for and press Enter.

**Method 2: Command Line**

1. Open the Start Menu, type `cmd`.
2. Click **"Run as administrator"**.
3. Navigate to your target folder using the `cd` command.
4. Run the script:
```WifiPasswordRetriever.bat```



**Terminal Output Example:**

```text
===============================================================================
+                                                                             +
+                     WI-FI PASSWORD RETRIEVER UTILITY                        +
+                                                                             +
===============================================================================
  Created by: Ben Timothy | GitHub: [https://github.com/BenTimothyM](https://github.com/BenTimothyM)
===============================================================================

[ Available Saved Wi-Fi Profiles ]
-------------------------------------------------------------------------------
    All User Profile     : HomeNetwork_5G
    All User Profile     : Cafe_Guest_WiFi
    All User Profile     : Office_Network
-------------------------------------------------------------------------------

Enter the Wi-Fi Profile Name: HomeNetwork_5G

Retrieving security settings...
-------------------------------------------------------------------------------
Profile Name           : HomeNetwork_5G
    Key Content            : MySuperSecretPassword123
-------------------------------------------------------------------------------

Press any key to continue . . .

[1] Check Another Wi-Fi
[2] Exit

Select an option: 

```

## 🤝 Contributing (Let's Learn Together!)

As this is a dedicated learning repository, contributions are highly encouraged! If you want to add features like exporting all passwords to a text file or optimizing the UI, feel free to pitch in:

1. Fork this repository.
2. Create your feature branch (`git checkout -b feature-export-to-txt`).
3. Commit your changes (`git commit -m 'Add option to export all passwords to a text file'`).
4. Push to your branch (`git push origin feature-export-to-txt`).
5. Open a Pull Request.

## 👨‍💻 Credits

This project is developed and maintained by:

* **Ben Timothy** - [@BenTimothyM](https://github.com/BenTimothyM) 



## 📜 License

This project is distributed under the **MIT License**. See the `LICENSE` file for more details.

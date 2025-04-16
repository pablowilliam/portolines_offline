
# Porto Lines Offline

This Flutter project provides detailed public transportation information for the city of Porto, Portugal, focusing on assisting students in navigating between different locations.

## Prerequisites

* Flutter SDK installed
* Dart SDK installed (automatically installed with the Flutter SDK)
* Visual Studio Code
* Ollama installed (follow the instructions below for your platform)
* Git installed

## Installation Instructions

### Ollama Installation

1.  **Install Ollama:**

    * **Windows:**
        * Go to: [https://ollama.ai/download](https://ollama.ai/download)
        * Download and run the installer.
    * **Linux:**
        * Open your terminal and execute:

            ```bash
            curl -fsSL https://ollama.com/install.sh | sh
            ```

    * **macOS:**
        * Go to: [https://ollama.ai/download](https://ollama.ai/download)
        * Download and run the installer. - Requires macOS 11 Big Sur or later

### Git Installation

1.  **Install Git:**

    * **Windows:**
        * Go to: [https://git-scm.com/download/win](https://git-scm.com/download/win)
        * Download and run the installer. Follow the on-screen instructions.
    * **Linux (Debian/Ubuntu):**
        * Open your terminal and execute:

            ```bash
            sudo apt-get update
            sudo apt-get install git
            ```

    * **Linux (Fedora/CentOS):**
        * Open your terminal and execute:

            ```bash
            sudo dnf install git
            ```

    * **macOS:**
        * Git is often pre-installed on macOS. If not, you can install it via Homebrew:

            ```bash
            brew install git
            ```

            * If you don't have Homebrew, install it from: [https://brew.sh/](https://brew.sh/)

## Execution Instructions

1.  **Clone the Repository:**

    * Open your terminal and execute the following command:

        ```bash
        git clone https://github.com/pablowilliam/portolines_offline.git
        ```

2.  **Navigate to the Project Folder:**

    * Move into the project directory:

        ```bash
        cd portolines_offline
        ```

3.  **Create Flutter Project:**

    * Create the Flutter project:

        ```bash
        flutter create .
        ```

4.  **Open the Project in Visual Studio Code:**

    * Open Visual Studio Code with the project:

        ```bash
        code .
        ```

5.  **Get Flutter Dependencies:**

    * In the Visual Studio Code terminal, run:

        ```bash
        flutter pub get
        ```

6.  **Run Ollama:**

    * Open a new terminal and start the Ollama server:

        ```bash
        ollama server
        ```

7.  **Pull and Run the Gemma3:1b Model:**

    * In the same terminal, execute:

        ```bash
        ollama pull gemma3:1b
        ollama run gemma3:1b
        ```
8.  **Run the Application in a Browser (Optional):**

    * To run the application in Chrome or Edge, open the **terminal in Visual Studio Code** and run one of the commands below:

        ```bash
        flutter run -d chrome
        flutter run -d edge
        ```
## Features

* Provides detailed public transport routes in Porto.
* Includes bus numbers, metro lines, and urban trains.
* Informs about departure and arrival times.
* Details necessary transfers between lines.
* Considers alternative transport like trams.

## Notes

* Ensure Ollama is running before using the Flutter application.
* The Gemma3:1b model will be downloaded if not already present.
* To run the Flutter application, use standard Flutter commands (e.g., `flutter run`).

## Contribution

Contributions are welcome! If you have suggestions for improvements or bug fixes, please open an issue or submit a pull request.
=======
# portolines_offline
An offline public transport assistant for the city of Porto — private, secure, and internet-free.

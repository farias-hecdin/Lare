# Lare
Reduce the bitrate of your MP3 files from the terminal.

## Description
Lare is a small and useful Bash script designed to work with **LAME MP3 Encoder**. The main goal of this script is to automate the bitrate reduction of a batch of MP3 files through the terminal.

> I created this script with the intention of reducing the bitrate of MP3 files on my phone, in order to optimize storage space and be able to save more songs.

## Requirements
To use Lare, you need to have [LAME MP3 Encoder](https://lame.sourceforge.io/) installed.

## Installation
Follow these steps to install Lare:

1. Clone this repository on your local machine:
   ```sh
   git clone https://github.com/farias-hecdin/Lare.git
   ```
2. Add this code snippet to your `.zshrc` or `.bashrc` file to be able to execute Lare from any directory.
   ```sh
   # Lare
   export LARE_HOME="$HOME/.local/share/lare:$PATH"
   ```

3. Run the `wizard.sh` file to install Lare:
    ```sh
    cd Lare/
    bash wizard.sh
    ```

4. Once you have installed Lare, you can run the script by writing the following command and specifying a directory:
    ```sh
    lare [directory]
    ```

To display the help text, you can use the `lare --help` command.

## Notes

> This error was fixed starting from version **v0.1.6**

If you experience an error when running the script, it may be due to spaces in the file names. This is because file names with spaces are interpreted as word separators.
Therefore, it is important to avoid spaces and replace them with hyphens (-) to ensure that the files can be properly read.

## License

Lare is under the MIT license. Please see the `LICENSE` file for more information.

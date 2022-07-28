# IF NO SUDO, THEN EXIT
if [ "$(id -u)" != "0" ]; then
    echo "Musisz uruchomić ten skrypt jako root" 1>&2
    echo "Spróbuj sudo $0"
    exit 1
fi

# INSTALL GIT
sudo apt-get install git -y
echo
echo "Git installed 🎉"
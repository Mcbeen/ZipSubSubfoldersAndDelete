#!/bin/bash
#Test123

processRoot() {
  if [ ! -d "$1" ]; then
    exit
  fi

  cd $1
  
  for d in */; do 
    zipAllFoldersInDir $d
  done
}

zipAllFoldersInDir() {
  for x in "${d%/}"/*; do
    if [ -d "$x" ]; then 
      echo "Zipping: $x"
      zip -rq "${x%/}.zip" "$x"
      rm -rf "$x"      
    fi
  done
}

startScript () {
  #Start the script
  echo "Would you like to process the following directory?" 
  echo "Current directory is ($1)."
  echo -n "Change if desired and/or press [ENTER]: "
  read userDir
  echo ""
  echo "This script will zip all subdirectories and delete them."
  echo "Processing directory ($1)."
  echo "Press [ENTER] to start: "
  read 

  if [ "$userDir" = "" ]; then 
    processRoot $1
  else
    processRoot $userDir
  fi
}

startScript $(pwd)
exit 1

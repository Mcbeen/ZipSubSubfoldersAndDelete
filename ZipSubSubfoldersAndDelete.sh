#!/bin/bash
processRoot() {
  if [ ! -d "$1" ]; then
    exit 1
  fi

  cd $1

  for subDir in */; do
    zipAllSubfoldersInDir "$1" "$subDir"
  done
}

zipAllSubfoldersInDir() {  
  cd "$1$2"
  for x in */; do
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
  echo "Change if desired and/or press [ENTER]: "
  read userDir
  echo ""
  echo "This script will zip all subdirectories and delete them."
  echo "Processing directory ($1)."
  echo -n "Press (y) to start: "
  read resumeProcessing
  
  if [ ! "$resumeProcessing" = "y" ]; then
    echo "Processing canceled! Exiting..."
    echo ""
    exit 1    
  fi

  if [ "$userDir" = "" ]; then 
    processRoot $1
  else
    processRoot $userDir
  fi
}

if [ $1 = "" ]; then
  startScript $(pwd)
else
  startScript $1
fi

exit 1

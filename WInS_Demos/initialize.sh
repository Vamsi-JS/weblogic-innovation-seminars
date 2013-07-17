#!/bin/sh

start_date=`date +%s`

#echo "Setting Oracle HTTP Proxy..."

#${DEMOS_HOME}/control/bin/setOracleProxy.sh
#. ~/setProxy.sh

echo "Creating domains..."

${DEMOS_HOME}/control/bin/rebuildDomains.sh

if [ "$?" == "0" ]; then
  echo "Installing applications into domains..."
  cd ${DEMOS_HOME}
  mvn -DskipTests=true install
fi

if [ "$?" != "0" ]; then
  echo "Error running Maven Sync Plugin"
  exit
fi

end_date=`date +%s`
duration=$(echo "scale=2; ($end_date-$start_date)/60" | bc)

echo "WInS Demo Environment Initialization complete in ${duration} minutes"
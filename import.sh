

    !/bin/bash  
    # Wanguard Script to gathering and update prefixes from Juniper devices
    # Serverion.com - 2022
     
     echo $'1. Getting prefixes from bird...OK'
     sleep 1
     birdc show route table zmr  | awk '/^[0-9]+/ { print $1}' > zmr.txt | echo 'ZMR... Done'
     birdc show route table nyc  | awk '/^[0-9]+/ { print $1}' > nyc.txt | echo 'NYC... Done'
     birdc show route table dal  | awk '/^[0-9]+/ { print $1}' > dal.txt | echo 'DAL... Done'
     birdc show route table lax  | awk '/^[0-9]+/ { print $1}' > lax.txt | echo 'LAX... Done'
     
     echo $"2. Prefixes found in Wanguard...OK"
       php /opt/andrisoft/api/cli_api.php ipzone "IP Zone ZMR" list | grep Internal | awk '{ print $1 }' > zmr_current.txt | echo 'ZMR...Done'
       php /opt/andrisoft/api/cli_api.php ipzone "IP Zone NYC" list | grep Internal | awk '{ print $1 }' > nyc_current.txt | echo 'NYC...Done' 
       php /opt/andrisoft/api/cli_api.php ipzone "IP Zone DAL" list | grep Internal | awk '{ print $1 }' > dal_current.txt | echo 'DAL...Done'
       php /opt/andrisoft/api/cli_api.php ipzone "IP Zone LAX" list | grep Internal | awk '{ print $1 }' > lax_current.txt | echo 'LAX...Done'
     sleep 1
     
     echo $'3. Removing prefixes from Wanguard...OK'
      for i in $(cat zmr_current.txt); do
       php /opt/andrisoft/api/cli_api.php ipzone "IP Zone ZMR" subnet "$i" delete > /dev/null
      done
      echo 'ZMR...Done'
      sleep 1
     
      for i in $(cat nyc_current.txt); do   
       php /opt/andrisoft/api/cli_api.php ipzone "IP Zone NYC" subnet "$i" delete > /dev/null
      done
      echo 'NYC...Done'
      sleep 1
     
      for i in $(cat dal_current.txt); do   
       php /opt/andrisoft/api/cli_api.php ipzone "IP Zone DAL" subnet "$i" delete > /dev/null
      done
      echo 'DAL...Done'
      sleep 1
     
      for i in $(cat lax_current.txt); do   
       php /opt/andrisoft/api/cli_api.php ipzone "IP Zone LAX" subnet "$i" delete > /dev/null
      done
      echo 'LAX...Done'
      sleep 1
     
     
     echo $'4. Inserting new routes in Wanguard API and linking thresholds...OK'
     for i in $(cat zmr.txt); do
        php /opt/andrisoft/api/cli_api.php ipzone "IP Zone ZMR" subnet "$i" add > /dev/null
        php /opt/andrisoft/api/cli_api.php ipzone "IP Zone ZMR" subnet "$i" set_ip_group "Internal Zone" > /dev/null
        php /opt/andrisoft/api/cli_api.php ipzone "IP Zone ZMR" subnet "$i" set_thresholds_template "Thresholds" > /dev/null
        php /opt/andrisoft/api/cli_api.php ipzone "IP Zone ZMR" subnet "$i" set_ip_graphs "Off" > /dev/null
        php /opt/andrisoft/api/cli_api.php ipzone "IP Zone ZMR" subnet "$i" set_ip_accounting "Off" > /dev/null
     done
     echo 'ZMR...Done'
     sleep 2
     for i in $(cat nyc.txt); do 
        php /opt/andrisoft/api/cli_api.php ipzone "IP Zone NYC" subnet "$i" add > /dev/null
        php /opt/andrisoft/api/cli_api.php ipzone "IP Zone NYC" subnet "$i" set_ip_group "Internal Zone" > /dev/null
        php /opt/andrisoft/api/cli_api.php ipzone "IP Zone NYC" subnet "$i" set_thresholds_template "Thresholds" > /dev/null
        php /opt/andrisoft/api/cli_api.php ipzone "IP Zone NYC" subnet "$i" set_ip_graphs "Off" > /dev/null
        php /opt/andrisoft/api/cli_api.php ipzone "IP Zone NYC" subnet "$i" set_ip_accounting "Off" > /dev/null
     done
     echo 'NYC..Done'
     sleep 2
     
     for i in $(cat dal.txt); do 
        php /opt/andrisoft/api/cli_api.php ipzone "IP Zone DAL" subnet "$i" add > /dev/null   
        php /opt/andrisoft/api/cli_api.php ipzone "IP Zone DAL" subnet "$i" set_ip_group "Internal Zone" > /dev/null
        php /opt/andrisoft/api/cli_api.php ipzone "IP Zone DAL" subnet "$i" set_thresholds_template "Thresholds" > /dev/null
        php /opt/andrisoft/api/cli_api.php ipzone "IP Zone DAL" subnet "$i" set_ip_graphs "Off" > /dev/null
        php /opt/andrisoft/api/cli_api.php ipzone "IP Zone DAL" subnet "$i" set_ip_accounting "Off" > /dev/null
     done
     echo 'DAL...Done'
     sleep 2
     
     for i in $(cat lax.txt); do 
        php /opt/andrisoft/api/cli_api.php ipzone "IP Zone LAX" subnet "$i" add > /dev/null   
        php /opt/andrisoft/api/cli_api.php ipzone "IP Zone LAX" subnet "$i" set_ip_group "Internal Zone" > /dev/null
        php /opt/andrisoft/api/cli_api.php ipzone "IP Zone LAX" subnet "$i" set_thresholds_template "Thresholds" > /dev/null
        php /opt/andrisoft/api/cli_api.php ipzone "IP Zone LAX" subnet "$i" set_ip_graphs "Off" > /dev/null
        php /opt/andrisoft/api/cli_api.php ipzone "IP Zone LAX" subnet "$i" set_ip_accounting "Off" > /dev/null
     done
     echo 'LAX...Done'
     sleep 1
     
     
     rm -rf zmr.txt lax.txt dal.txt nyc.txt zmr_current.txt nyc_current.txt lax_current.txt dal_current.txt | echo 'Files removed'
     sleep 3
     echo 'All done!'


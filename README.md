# website_checker
Bash script for checking and logging if any given website is available.

This script has mainly just been for practice with scripting and logging.

Functionality:
- Checks if a given website (provided via command line variable) responds with a good (200) HTTP response code.
- If it does not, then it checks to see if the device itself can contact Google (as a control to check for internet connectivity)
- This information is logged each time the script is ran and the logs are rotated when they reach around 42kb
- This script is designed to be run via crontab

Usage:
$ ./website_checker.sh github.com

#!/bin/bash

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
RESET='\033[0m'  # Reset color to default

echo -e "${CYAN}###############################${RESET}"
echo -e "${CYAN}#${RESET}  ${GREEN}$(figlet -f slant 'Wayback URL Fetcher')${CYAN} #${RESET}"

echo -e "${CYAN}#${RESET}  ${YELLOW}$(figlet -f small 's1mon0v')${CYAN} #${RESET}"
echo -e "${CYAN}###############################${RESET}"

# Prompt for the domain name.
echo -e "${CYAN}Enter the domain (e.g., example.com): ${RESET}"
read domain

echo -e "\n${GREEN}Fetching all URLs from the Wayback Machine...${RESET}"
# Fetch all URLs for the given domain.
curl -G "https://web.archive.org/cdx/search/cdx" \
  --data-urlencode "url=*.$domain/*" \
  --data-urlencode "collapse=urlkey" \
  --data-urlencode "output=text" \
  --data-urlencode "fl=original" \
  -o all_urls.txt

echo -e "\n${YELLOW}Fetching URLs with specific file extensions...${RESET}"
# Fetch only URLs ending with certain file extensions.
# (Adjust the extension list if necessary.)
curl "https://web.archive.org/cdx/search/cdx?url=*.$domain/*&collapse=urlkey&output=text&fl=original&filter=original:.*\.(xls|xml|xlsx|json|pdf|sql|doc|docx|pptx|txt|git|zip|tar\.gz|tgz|bak|7z|rar|log|cache|secret|db|backup|yml|gz|config|csv|yaml|md|md5|exe|dll|bin|ini|bat|sh|tar|deb|rpm|iso|img|env|apk|msi|dmg|tmp|crt|pem|key|pub|asc)$" \
  -o filtered_urls.txt

echo -e "\n${BLUE}Done! Results saved to:${RESET}"
echo -e "  - ${CYAN}all_urls.txt${RESET} (all URLs)"
echo -e "  - ${CYAN}filtered_urls.txt${RESET} (URLs with specific file extensions)"


LOGIN_URL=https://vwap-offset.herokuapp.com/admin/login/?next=/admin/
YOUR_USER=''
YOUR_PASS=''
COOKIES=cookies.txt
CURL_BIN="curl -s -c $COOKIES -b $COOKIES -e $LOGIN_URL"

printf "1 - Django Auth: getting csrftoken. \n"
$CURL_BIN $LOGIN_URL > /dev/null
DJANGO_TOKEN="csrfmiddlewaretoken=$(grep csrftoken $COOKIES | sed 's/^.*csrftoken\s*//')"

printf "2 - Performing login. \n"
$CURL_BIN \
    -d "$DJANGO_TOKEN&username=$YOUR_USER&password=$YOUR_PASS" \
    -X POST $LOGIN_URL

printf "3 - Getting new token from form page html. \n"
FORM_HTML=$($CURL_BIN \
    -H "$DJANGO_TOKEN&..." \
    -X GET https://vwap-offset.herokuapp.com/save/config/input/)

# Getting form token
DJANGO_TOKEN_2="csrfmiddlewaretoken=$(echo "$FORM_HTML" | grep csrfmiddlewaretoken | sed 's/^.*value\s*//' | sed 's/^.//;s/.$//' | sed 's/^.//;s/.$//')"

# Read config file
FILE_CONTENT=$(cat varPairs.json)

printf "4 - Saving Config. \n"
$CURL_BIN \
    -d "$DJANGO_TOKEN_2&file_content=$FILE_CONTENT" \
    -X POST https://vwap-offset.herokuapp.com/save/config/

printf "5 - Logout \n"
# Cleanup
rm $COOKIES

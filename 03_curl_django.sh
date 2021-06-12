LOGIN_URL=https://vwap-offset.herokuapp.com/admin/login/?next=/admin/
YOUR_USER=''
YOUR_PASS=''
COOKIES=cookies.txt
CURL_BIN="curl -s -c $COOKIES -b $COOKIES -e $LOGIN_URL"

echo -n "Django Auth: get csrftoken ..."
$CURL_BIN $LOGIN_URL > /dev/null
DJANGO_TOKEN="csrfmiddlewaretoken=$(grep csrftoken $COOKIES | sed 's/^.*csrftoken\s*//')"

echo -n " perform login ..."
$CURL_BIN \
    -d "$DJANGO_TOKEN&username=$YOUR_USER&password=$YOUR_PASS" \
    -X POST $LOGIN_URL

echo -n " do something while logged in ..."
FORM_HTML=$($CURL_BIN \
    -H "$DJANGO_TOKEN&..." \
    -X GET https://vwap-offset.herokuapp.com/save/config/input/)

#echo $FORM_HTML

# Getting form token
DJANGO_TOKEN_2=$(echo "$FORM_HTML" | grep csrfmiddlewaretoken | sed 's/^.*value\s*//' | sed 's/^.//;s/.$//' | sed 's/^.//;s/.$//')
echo $DJANGO_TOKEN_2





echo " logout"
rm $COOKIES
sleep 10
webAdress=$(kubectl get svc | grep -i webserver-loadbalancer | awk -F ' ' '{print $4}')
curl $webAdress > newhtml.txt
echo $webAdress
cat newhtml.txt

dos2unix newhtml.txt index.html
checkForDiff=$(cmp newhtml.txt index.html | wc -l)
if [[ checkForDiff -gt 0 ]]
then
    echo "Live website differs from updated website. exiting...."
    diff newhtml.txt index.html
    exit 1
else
    echo "Live website matches the updated website. Great!"
fi
https://reduce-link.herokuapp.com/api-docs/index.html

It works similar to bit.ly.
This app was deployed to herokuapp.
It creates short uniq url for any kind of links. 
When generating link program checks if it has already been there in database. 
If it finds that link exists, it generates new. 
If the database is filled with many generated existed links with certain number of chars
usually it may increase time to get it.
In order to decrease this time new char will be adding for generating new link.

Example of generating link on herokuapp:
You can write any valid url:
{
"user_url": "google.com"
}

When you press button execute it produce uniq link. 

{
"nickname": "ACF7T",
"redirect_url": "https://reduce-link.herokuapp.com/ACF7T"
}

In order to check if link works, just copy and 
paste: https://reduce-link.herokuapp.com/ACF7T to address bar of your web browser and press "Enter"
It will redirect to the original site - google.com

If you do not need this link, just take generated part of link in "nickname": "ACF7T"
and paste it to description field and press "Execute". 
You will get message that it was removed. 


function getFront(mainStr, searchStr)
{
  foundOffset = mainStr.indexOf(searchStr);
  if (foundOffset == -1) {
    return null;
  }
 return mainStr.substring(0,foundOffset);
}

function getEnd(mainStr,searchStr) 
{
  foundOffset = mainStr.indexOf(searchStr);
   if (foundOffset == -1) {
     return null;
   }
  return mainStr.substring(foundOffset+searchStr.length, mainStr.length);
}

function replaceString(mainStr,searchStr,replaceStr) 
{
 var front = getFront(mainStr,searchStr);
 var end = getEnd(mainStr,searchStr);
 if (front != null && end != null) { 
  return front + replaceStr + end;
 }
 return mainStr;
}

function replaceMail(mailStr)
{
return replaceString(replaceString(replaceString(replaceString(mailStr, "[dot]", "."), "[dot]", "."), "[dot]", "."),"[at]","@")
}

function gotoEmail(mailStr)
{ document.location.replace("mailto:"+replaceMail(mailStr));
  
}
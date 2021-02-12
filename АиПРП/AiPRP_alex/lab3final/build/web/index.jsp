<!DOCTYPE html> 
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<html> 
    <head> 
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 
    </head> 
    <body bgcolor="#aaccff"> 
        <Font color="green" size="10"> Vocabulary </Font>
        <br/> 
        <br/> 
        <form name="frm" method="Get" action="MyServlet">
            <Font color="blue" size="6"> Введите слово:</Font>
            <Input type="Text" name="txt" value="${txt}"/> 
            <br/> 
            <br/> 
            <Font color="blue" size="6">Перевод </Font>
            <input type="text" name ="trans" value="${trans}"/>
            <br/> 
            <Input type="submit" value="Перевести"/> 
        </form>
    </body>
</html>
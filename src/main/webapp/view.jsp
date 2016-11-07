<%@ page import="java.util.Enumeration" %>
<%@ page import="com.liferay.portal.model.User" %>
<%@ page import="javax.portlet.*" %>
<%@ page import="java.util.Map" %><%--
/**
 * Copyright (c) 2000-present Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
--%>

<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib prefix="theme" uri="http://liferay.com/tld/theme" %>

<portlet:defineObjects />
<theme:defineObjects />

This is the <b>co_portlet</b>.

<%
    PortletSession pSession = renderRequest.getPortletSession();
    String secred = new String();
    String digest = new String();
    User userU = themeDisplay.getUser();
    String loginName = userU.getLogin();
    if(pSession != null)
    {

        System.out.println("renderRequest: " + renderRequest);
        System.out.println("renderResponse: " + renderResponse);
        System.out.println("resourceRequest: " + resourceRequest);
        System.out.println("resourceResponse: " + resourceResponse);
        System.out.println("actionRequest: " + actionRequest);
        System.out.println("actionResponse: " + actionResponse);
        System.out.println("eventRequest: " + eventRequest);
        System.out.println("eventResponse: " + eventResponse);
        System.out.println("portletConfig: " + portletConfig);
        System.out.println("portletSession: " + portletSession);
        System.out.println("portletSessionScope: " + portletSessionScope.toString());
        System.out.println("portletPreferences: " + portletPreferences);
        System.out.println("portletPreferencesValues: " + portletPreferencesValues.toString());


        System.out.println("user.login: " + userU.getLogin());
        System.out.println("user.pwd: " + userU.getPasswordUnencrypted());
        System.out.println("user.digest: " + userU.getDigest());
        digest = userU.getDigest();
        System.out.println("pSession: " + pSession.toString());
        System.out.println("pSession.getID: " + pSession.getId());
        System.out.println("pSession.size: " + pSession.getAttributeMap().size());

        System.out.println("pSession.portalcontext: " + pSession.getPortletContext().toString());

        for (Enumeration<String> e = pSession.getAttributeNames(); e.hasMoreElements();){
            secred = secred + e.nextElement();
            System.out.println(secred);
        }

    }


%>



<script >

    console.log('secred: ' + '<% out.write(secred); %>');
    var digest = {};
    digest.text = '<% out.write(digest); %>';
    digest.splitted = digest.text.split(',');
    var userName = '<% out.write(loginName); %>';
    console.log('document.digestarray: ' + digest.splitted.toString());
	console.log('window.document.cookie: ' + window.document.cookie);
	console.log('Liferay.authToken: ' + Liferay.authToken);


    function say0() {
        getIt('/api/jsonws/devservice-portlet.wanted/say-goodbye');
    }
	function say1() {
        getIt('/api/jsonws/devservice-portlet.wanted/say-goodbye?p_auth='+ Liferay.authToken);
    }
    function say2() {
        getIt('/api/jsonws/devservice-portlet.wanted/say-goodbye2?p_auth='+ Liferay.authToken);
    }

	function getIt(url){
		var xhr = new XMLHttpRequest();
		xhr.open('GET', url, true);
/*        xhr.withCredentials = true;*/
        xhr.addEventListener('load', function(event) {
			   if (xhr.status >= 200 && xhr.status < 300) {
			       console.log(xhr.responseText);
                   printOut(xhr.responseText);
			   } else {
			       console.warn(xhr.statusText, xhr.responseText);
                   printOut(xhr.responseText);

			   }
			});
		xhr.send();
	}

    function setName() {
        document.getElementById("loginname").innerHTML = userName;
    }
	function printOut(output){
        document.getElementById("result").innerHTML = output;
    }

</script>

<div>Name:</div>
<div id="loginname"></div>
<div>
    <button onclick="setName()">say2</button>
</div>

<div>Result:</div>

<div id="result"></div>
<div>
    <button onclick="say0()">say0</button>
    <button onclick="say1()">say1</button>
    <button onclick="say2()">say2</button>
</div>

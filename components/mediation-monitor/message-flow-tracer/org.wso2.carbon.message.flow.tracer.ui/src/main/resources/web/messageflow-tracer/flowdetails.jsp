<%@ page import="org.apache.axis2.context.ConfigurationContext" %>
<%@ page import="org.wso2.carbon.CarbonConstants" %>
<%@ page import="org.wso2.carbon.ui.CarbonUIUtil" %>
<%@ page import="org.wso2.carbon.utils.ServerConstants" %>
<%@ page import="org.wso2.carbon.ui.CarbonUIMessage" %>
<%@ page import="org.wso2.carbon.message.flow.tracer.ui.MessageFlowTracerClient" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://wso2.org/projects/carbon/taglibs/carbontags.jar" prefix="carbon" %>
<fmt:bundle basename="org.wso2.carbon.message.flow.tracer.ui.i18n.Resources">
    <carbon:breadcrumb label="message.flow.details"
                       resourceBundle="org.wso2.carbon.message.flow.tracer.ui.i18n.Resources"
                       topPage="false" request="<%=request%>"/>
<%
    String serverURL = CarbonUIUtil.getServerURL(config.getServletContext(), session);
    ConfigurationContext configContext =
            (ConfigurationContext) config.getServletContext().getAttribute(CarbonConstants.CONFIGURATION_CONTEXT);
    String cookie = (String) session.getAttribute(ServerConstants.ADMIN_SERVICE_COOKIE);
%>
<%
    MessageFlowTracerClient client;
    String messageId = request.getParameter("messageid");

    String flowTraceJson;

    String[] flowTraceLevels;

    try {
        client = new MessageFlowTracerClient(configContext, serverURL, cookie);
        flowTraceJson = client.getMessageFlowTraceInJson(messageId);
        flowTraceLevels = client.getMessageFlowTraceInLevel(messageId);
    } catch (Exception e) {
        CarbonUIMessage.sendCarbonUIMessage(e.getMessage(), CarbonUIMessage.ERROR, request, e);
%>
    <script type="text/javascript">
        location.href = "../admin/error.jsp";
    </script>
    <%
            return;
        }
    %>

    <h4>Flow Trace</h4>
    <br>

    <script type='text/javascript' src='jquery-1.8.3.js'></script>

    <link rel="stylesheet" type="text/css" href="/css/normalize.css">


    <link rel="stylesheet" type="text/css" href="/css/result-light.css">

    <style type='text/css'>
        #wrapper {
            position: relative;
        }

        .component {
            position: absolute;
            border: 1px solid #000;
            height: 30px;
            padding: 5px;
            width: 90px;
        }
    </style>

    <script>
        function a(item) {
            alert(item.offsetParent.id);
        }

        function process(key,value,componentId) {
            if(value.componentId = componentId){
                alert(value.entries)
            }
        }

        function traverse(o,func,componentId) {
            for (var i in o) {
                func.apply(this,[i,o[i]],componentId);
                if (o[i] !== null && typeof(o[i])=="object") {
                    //going on step down in the object tree!!
                    traverse(o[i],func);
                }
            }
        }
    </script>

    <script type='text/javascript'>//<![CDATA[
    $(window).load(function(){

        var jsonObj = <%=flowTraceJson%>;

        var create_graph_components = function (json, level, offsetStart) {

            var offsetEnd = offsetStart;

            for (var i = 0; i < json.nodeList.length; i++) {
                offsetEnd = create_graph_components(json.nodeList[i], level + 1, offsetEnd);
            }

            var offset;
            if (json.nodeList.length == 0) {
                offset = offsetEnd;
                // Node is a leaf therefore extend offsetEnd
                offsetEnd += 50;
            } else {
                // Calculates position halfway between child nodes
                offset = offsetStart + (offsetEnd - offsetStart - 50) / 2;
                // Node is a branch therefore we do not extend the offsetEnd
            }

            // Create the element
            var child = $('<div id="' + json.componentId + '" class="component window">' +
            '<strong onclick="a(this)">' + json.componentName + '</strong>' +
            '</div>');

            // Position the element
            child.css({
                top: offset + "px",
                left: level * 150 + "px"
            });

            // Add it to the wrapper
            $("#wrapper").append(child);

            return offsetEnd;

        };

        create_graph_components(jsonObj, 0, 0);

    });//]]>

    </script>
    <div id="wrapper"></div>

    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>

    <%
        for (String level:flowTraceLevels){%>
            <%=level%>
            <br>
        <%}
    %>

</fmt:bundle>
<%@ page import="org.apache.axis2.context.ConfigurationContext" %>
<%@ page import="org.wso2.carbon.CarbonConstants" %>
<%@ page import="org.wso2.carbon.ui.CarbonUIUtil" %>
<%@ page import="org.wso2.carbon.utils.ServerConstants" %>
<%@ page import="org.wso2.carbon.ui.CarbonUIMessage" %>
<%@ page import="org.wso2.carbon.message.flow.tracer.ui.MessageFlowTracerClient" %>
<%@ page import="org.wso2.carbon.message.flow.tracer.data.xsd.ComponentNode" %>
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

    String[] flowTrace;

    try {
        client = new MessageFlowTracerClient(configContext, serverURL, cookie);
        flowTrace = client.getMessageFlowTrace(messageId);
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

    <%
        for (String level:flowTrace){%>
           <%=level%>
        <br>
        <%}
    %>

</fmt:bundle>
package org.wso2.carbon.message.flow.tracer;

import org.apache.synapse.flowtracer.data.MessageFlowComponentEntry;
import org.apache.synapse.flowtracer.data.MessageFlowTraceEntry;
import org.apache.synapse.flowtracer.MessageFlowDbConnector;

import java.util.Map;

public class MessageFlowTracerService {

    private MessageFlowDbConnector messageFlowDbConnector;

    public MessageFlowTracerService() {
        messageFlowDbConnector = MessageFlowDbConnector.getInstance();
    }

    public MessageFlowTraceEntry[] getMessageFlows(){
        Map<String,MessageFlowTraceEntry> messageFlows = messageFlowDbConnector.getMessageFlows();

        if(messageFlows.values().size()==0)
            return new MessageFlowTraceEntry[1];

        return messageFlows.values().toArray(new MessageFlowTraceEntry[messageFlows.values().size()]);
    }

    public String[] getMessageFlowInfo(String messageId){
        String[] messageFlows = messageFlowDbConnector.getMessageFlowInfo(messageId);

        return messageFlows;
    }

    public MessageFlowComponentEntry[] getComponentInfo(String messageId, String componentId){
        return new MessageFlowComponentEntry[2];
    }

    public void clearAll(){
        messageFlowDbConnector.clearTable();
    }
}
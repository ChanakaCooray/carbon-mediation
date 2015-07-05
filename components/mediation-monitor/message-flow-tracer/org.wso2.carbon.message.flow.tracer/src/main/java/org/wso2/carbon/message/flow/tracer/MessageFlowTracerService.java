package org.wso2.carbon.message.flow.tracer;

import org.apache.synapse.flowtracer.data.MessageFlowComponentEntry;
import org.apache.synapse.flowtracer.data.MessageFlowTraceEntry;
import org.apache.synapse.flowtracer.MessageFlowDbConnector;
import org.codehaus.jackson.map.ObjectMapper;
import org.wso2.carbon.message.flow.tracer.data.FlowPath;

import java.io.IOException;
import java.util.*;

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

//    public String[] getMessageFlowInfo(String messageId){
//        String[] messageFlows = messageFlowDbConnector.getMessageFlowInfo(messageId);
//
//        return messageFlows;
//    }

    public MessageFlowComponentEntry[] getComponentInfo(String messageId, String componentId){
        return new MessageFlowComponentEntry[2];
    }

//    public ComponentNode getMessageFlow(String messageId){
//        String[] messageFlows = messageFlowDbConnector.getMessageFlowInfo(messageId);
//
//        MessageFlowComponentEntry[] messageFlowComponentEntries = messageFlowDbConnector.getComponentInfo(messageId);
//
//        FlowPath flowPath = new FlowPath(messageFlows,messageFlowComponentEntries);
//
//        return flowPath.getHead();
//    }

    public String[] getMessageFlowInLevels(String messageId){
        String[] messageFlows = messageFlowDbConnector.getMessageFlowInfo(messageId);

        MessageFlowComponentEntry[] messageFlowComponentEntries = messageFlowDbConnector.getComponentInfo(messageId);

        FlowPath flowPath = new FlowPath(messageFlows,messageFlowComponentEntries);

        Map<Integer,List<String>> levelMap = new TreeMap<>();

        List<String> initialList = new ArrayList<>();
        initialList.add(flowPath.getHead().getEntries().get(0).getComponentName());
        levelMap.put(0,initialList);

        flowPath.buildFlowWithLevels(levelMap,1,flowPath.getHead());

        String[] levels = new String[levelMap.size()];

        for(Integer i:levelMap.keySet()){
            levels[i] = levelMap.get(i).toString();
        }

        return levels;
    }

    public String getMessageFlowInJson(String messageId){
        String[] messageFlows = messageFlowDbConnector.getMessageFlowInfo(messageId);

        MessageFlowComponentEntry[] messageFlowComponentEntries = messageFlowDbConnector.getComponentInfo(messageId);

        FlowPath flowPath = new FlowPath(messageFlows,messageFlowComponentEntries);

        ObjectMapper mapper = new ObjectMapper();

        String jsonString = null;

        try {
            jsonString = mapper.writeValueAsString(flowPath.getHead());
        } catch (IOException e) {
            e.printStackTrace();
        }

        return jsonString;
    }

    public void clearAll(){
        messageFlowDbConnector.clearTable();
    }
}
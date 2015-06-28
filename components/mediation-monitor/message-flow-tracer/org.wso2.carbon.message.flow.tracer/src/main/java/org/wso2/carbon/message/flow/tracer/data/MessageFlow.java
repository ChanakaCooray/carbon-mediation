package org.wso2.carbon.message.flow.tracer.data;

public class MessageFlow {

    private String messageId;
    private String type;
    private double processTime;
    private String timeStamp;

    public MessageFlow(String messageId, String type, double processTime, String timeStamp) {
        this.messageId = messageId;
        this.type = type;
        this.processTime = processTime;
        this.timeStamp = timeStamp;
    }

    public String getMessageId() {
        return messageId;
    }

    public void setMessageId(String messageId) {
        this.messageId = messageId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public double getProcessTime() {
        return processTime;
    }

    public void setProcessTime(double processTime) {
        this.processTime = processTime;
    }

    public String getTimeStamp() {
        return timeStamp;
    }

    public void setTimeStamp(String timeStamp) {
        this.timeStamp = timeStamp;
    }
}

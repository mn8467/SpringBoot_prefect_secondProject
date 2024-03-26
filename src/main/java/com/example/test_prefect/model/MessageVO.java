package com.example.test_prefect.model;

import lombok.Data;

@Data
public class MessageVO {
    private String msgId;//메시지ID
    private String msgContents;//메지시 내용

    public MessageVO() {}

    public MessageVO(String msgId, String msgContents) {
        super();
        this.msgId = msgId;
        this.msgContents = msgContents;
    }

    public String getMsgId() {
        return msgId;
    }

    public void setMsgId(String msgId) {
        this.msgId = msgId;
    }

    public String getMsgContents() {
        return msgContents;
    }

    public void setMsgContents(String msgContents) {
        this.msgContents = msgContents;
    }

    @Override
    public String toString() {
        return "MessageVO [msgId=" + msgId + ", msgContents=" + msgContents + "]";
    }


}

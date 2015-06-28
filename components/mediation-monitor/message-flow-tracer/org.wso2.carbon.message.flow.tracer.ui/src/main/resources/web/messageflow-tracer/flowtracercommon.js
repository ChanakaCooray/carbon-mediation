function flowDetails(messageID) {
    document.location.href = "flowdetails.jsp?" + "messageid=" + messageID;
}

function clearAllNew() {
    document.location.href = "index.jsp?op=clear";
}
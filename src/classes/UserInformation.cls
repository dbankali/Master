global class UserInformation{
WebService static String getContextUserName() {
return UserInfo.getName();
}
WebService static String getContextUserId() {
return UserInfo.getUserId();
}
WebService static String getContextUserFirstName() {
return UserInfo.getFirstName();
}
WebService static String getContextProfileId() {
return UserInfo.getProfileId();
}
}
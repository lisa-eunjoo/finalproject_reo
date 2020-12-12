package kr.co.reo.client.member;

public class AuthInfo {
	private String clientId;
	private String clientSecret;

	public AuthInfo(String clientId, String clientSecret) {
		this.clientId = "908307470180-5g8cinsceuaioqef7u39rp23mj8okgj0.apps.googleusercontent.com";
		this.clientSecret = "IZO1bCh5XL7v-ByEwgCfBggA";
	}

	public String getClientId() {
		return clientId;
	}

	public String getClientSecret() {
		return clientSecret;
	}
}

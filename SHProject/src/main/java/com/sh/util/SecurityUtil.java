package com.sh.util;

import java.security.Key;

import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

import org.apache.log4j.Logger;

//import org.apache.commons.codec.binary.Base64;

/**
 * Util Class for Encryption and Decryption purpose
 * 
 * @author ravi.brahmbhatt
 *
 */
public class SecurityUtil {
	final static Logger logger = Logger.getLogger(SecurityUtil.class);

	private static final String ALGO = "AES";

	private static final byte[] privateKey1 = new byte[] { 'T', 'h', 'e', 't', 'K', 'e', '!', 'A', 'D', 'R', 'T', '(',
			'H', 'J', 'Z', 'B' };
	private static Key key = generateKey();

	/**
	 * This method is used for encryption
	 * 
	 * @param Data
	 * @return
	 * @throws Exception
	 */
	public static String encrypt(String Data) throws Exception {

		Cipher cipher = Cipher.getInstance(ALGO);
		cipher.init(Cipher.ENCRYPT_MODE, key);
		byte[] encVal = cipher.doFinal(Data.getBytes());
		String encryptedValue = Base64.getEncoder().encodeToString(encVal);
		return encryptedValue;
	}

	/**
	 * This method is for decryption
	 * 
	 * @param encryptedData
	 * @return
	 * @throws Exception
	 */
	public static String decrypt(String encryptedData) throws Exception {

		Cipher cipher = Cipher.getInstance(ALGO);
		cipher.init(Cipher.DECRYPT_MODE, key);
		byte[] decordedValue = Base64.getDecoder().decode(encryptedData);
		byte[] decValue = cipher.doFinal(decordedValue);
		String decryptedValue = new String(decValue);
		return decryptedValue;
	}

	/**
	 * This method selects appropriate key value and generates the key
	 * 
	 * @return
	 * @throws Exception
	 */
	private static Key generateKey() {

		key = new SecretKeySpec(privateKey1, ALGO);
		return key;

	}
	
	public static void main(String[] args) throws Exception {
		System.out.println(encrypt("test123"));
	}
}

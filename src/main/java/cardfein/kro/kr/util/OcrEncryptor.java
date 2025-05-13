package cardfein.kro.kr.util;

import org.jasypt.util.text.BasicTextEncryptor;

public class OcrEncryptor {
    private static final String key = ConfigLoader.getProperty("jasypt.key");
    private static final BasicTextEncryptor encryptor = new BasicTextEncryptor();

    static {
        encryptor.setPassword(key);
    }

    public static String encrypt(String plainText) {
        return encryptor.encrypt(plainText);
    }

    public static String decrypt(String cipherText) {
        return encryptor.decrypt(cipherText);
    }
}